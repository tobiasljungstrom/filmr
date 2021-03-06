package filmr.controllers;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.function.Function;
import java.util.stream.Collectors;

import filmr.helpers.exceptions.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import filmr.domain.Movie;
import filmr.domain.Seat;
import filmr.domain.Showing;
import filmr.domain.Theater;

import filmr.helpers.TimeslotCreator;
import filmr.services.ShowingService;

@RestController
@RequestMapping(value = "/api/showings")
public class ShowingController extends BaseController {

	private final static LocalDateTime ERROR_DATE_TIME = LocalDateTime.of(6, 6, 6, 6, 6);

    @Autowired
    private ShowingService showingService;

    @CrossOrigin
    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<Showing> createShowing(@RequestBody Showing showing) throws FilmrInvalidDateFormatException, FilmrPOSTRequestWithPredefinedIdException, FilmrShowingTimeOccupiedException, FilmrPastDateException {
       
    	if(showing.getId() != null) throw new FilmrPOSTRequestWithPredefinedIdException("Trying to create showing, but showing already has id.");
        
        if(showing.getShowDateTime().equals(ERROR_DATE_TIME)) throw new FilmrInvalidDateFormatException();

	    if(showing.getShowDateTime().isBefore(LocalDateTime.now())) throw new FilmrPastDateException();
        
        Boolean showingTimeNotOccupied = showingService.showingTimeNotOccupied(showing); //TODO: show time valid is to generic IMO. rename to time is occupied or make method return type of invalid error

        if(showingTimeNotOccupied){
            Showing savedShowing = showingService.saveEntity(showing);
            return new ResponseEntity<Showing>(savedShowing, HttpStatus.OK);
        }
        logger.warn("Not valid time");
        throw new FilmrShowingTimeOccupiedException("Chosen time for showing is already occupied");

    }

    @CrossOrigin
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ResponseEntity<Showing> readShowing(
    		@PathVariable Long id,
    		@RequestParam(name="mark_seat_booking_status", defaultValue="false", required=false) Boolean mark_seat_booking_status
    		){
        logger.debug("in read showing.");
    	Showing retrievedShowing = showingService.readEntity(id);
        
        if(mark_seat_booking_status){
        	markBookingStatusForSeats(retrievedShowing);        	
        }

        return new ResponseEntity<Showing>(retrievedShowing, HttpStatus.OK);
    }

    
    @CrossOrigin
    @RequestMapping(method = RequestMethod.GET)
    public ResponseEntity<List<Showing>> readAllShowings(
    		@RequestParam(name="from_date", required=false) @DateTimeFormat(iso = ISO.DATE_TIME) LocalDateTime from_date, // @DateTimeFormat(iso = ISO.DATE) seems to work when we retrieve javascript Date objects
    		@RequestParam(name="to_date", required=false) @DateTimeFormat(iso = ISO.DATE_TIME) LocalDateTime to_date,
    		@RequestParam(name="minimum_available_tickets", required=false) Long minimum_available_tickets,
    		@RequestParam(name="only_for_movie_with_id", required=false) Long only_for_movie_with_id,
    		@RequestParam(name="only_for_theater_with_id", required=false) Long only_for_theater_with_id,
    		@RequestParam(name="only_for_cinema_with_id", required=false) Long only_for_cinema_with_id,
    		@RequestParam(name="limit", required=false, defaultValue = "50") Integer limit,
    		@RequestParam(name="show_disabled_showings", required=false, defaultValue = "false") Boolean show_disabled_showings,
    		@RequestParam(name="include_distinct_movies_in_header", required=false, defaultValue = "false") Boolean include_distinct_movies_in_header,
    		@RequestParam(name="include_empty_slots_for_movie_of_length", required=false) Long include_empty_slots_for_movie_of_length
    		) {
    	
    	logger.info("from date, before manipulation: " + from_date);
    	logger.info("to date, before manipulation: " + to_date);
    	
    	// default values that are hard to code as strings.. If not null -> use the value, else provide a default value
		from_date = from_date != null ? from_date : LocalDateTime.now();

		logger.info("From date: " + from_date);
		logger.info("To date: " + to_date);
		
		List<Showing> retrievedShowings = showingService.getAllMatchingParams(
						from_date, 
						to_date, 
						minimum_available_tickets, 
						only_for_movie_with_id,
						only_for_theater_with_id,
						only_for_cinema_with_id,
						limit,
						show_disabled_showings
				);
	
    	HttpHeaders customHeaders = null;

        if(include_distinct_movies_in_header) {
        	logger.info("Trying to include distinct movies in http header.");
            try {
                customHeaders = buildCustomHeadersForReadAll(retrievedShowings);
            } catch (JsonProcessingException e) {
                logger.warn("Couldn't parse movie list into JSON");
                e.printStackTrace();
                return ResponseEntity.status(HttpStatus.PARTIAL_CONTENT).body(retrievedShowings);
            }
            return ResponseEntity.ok().headers(customHeaders).body(retrievedShowings);
        }
        
        if(include_empty_slots_for_movie_of_length != null) {
        	retrievedShowings = 
        			TimeslotCreator.createExtendedShowingsListWithEmptyTimeSlots(retrievedShowings, include_empty_slots_for_movie_of_length);        	
        }
        return new ResponseEntity<List<Showing>>(retrievedShowings, HttpStatus.OK);
    }

    @CrossOrigin
    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    public ResponseEntity<Showing> updateShowing(@PathVariable Long id, @RequestBody Showing showing) throws FilmrPUTRequestWithMissingEntityIdException, FilmrInvalidDateFormatException{
        
    	if(showing.getId() == null) throw new FilmrPUTRequestWithMissingEntityIdException("Trying to update Showing but entity is missing id.");
    	
    	if(showing.getShowDateTime().equals(ERROR_DATE_TIME)) throw new FilmrInvalidDateFormatException();
    	
    	
        Showing updatedShowing = showingService.saveEntity(showing);
        return new ResponseEntity<Showing>(updatedShowing, HttpStatus.OK);
    }

    @CrossOrigin
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public ResponseEntity deleteShowing(@PathVariable Long id) {
        showingService.deleteEntity(id);
        return new ResponseEntity(HttpStatus.OK);
    }
    
    
    @CrossOrigin
    @RequestMapping(value = "/schedule", method = RequestMethod.GET)
    public ResponseEntity<? extends Object> readAllShowingsSchedule(
    		@RequestParam(name="from_date", required=false) @DateTimeFormat(iso = ISO.DATE_TIME) LocalDateTime from_date, // @DateTimeFormat(iso = ISO.DATE) seems to work when we retrieve javascript Date objects
    		@RequestParam(name="to_date", required=false) @DateTimeFormat(iso = ISO.DATE_TIME) LocalDateTime to_date,
    		@RequestParam(name="minimum_available_tickets", required=false) Long minimum_available_tickets,
    		@RequestParam(name="only_for_movie_with_id", required=false) Long only_for_movie_with_id,
    		@RequestParam(name="only_for_theater_with_id", required=false) Long only_for_theater_with_id,
    		@RequestParam(name="only_for_cinema_with_id", required=false) Long only_for_cinema_with_id,
    		@RequestParam(name="limit", required=false, defaultValue = "50") Integer limit,
    		@RequestParam(name="show_disabled_showings", required=false, defaultValue = "false") Boolean show_disabled_showings,
    		@RequestParam(name="include_distinct_movies_in_header", required=false, defaultValue = "false") Boolean include_distinct_movies_in_header,
    		@RequestParam(name="include_empty_slots_for_movie_of_length", required=false) Long include_empty_slots_for_movie_of_length,
    		@RequestParam(name="group_by_theater", required=false, defaultValue="true") Boolean group_by_theater
    		
    		) {
    	
    	// reuse existing readAll method
    	ResponseEntity<List<Showing>> ungroupedShowingsResponseEntity = readAllShowings(
    					from_date, 
    					to_date, minimum_available_tickets, 
    					only_for_movie_with_id, only_for_theater_with_id, 
    					only_for_cinema_with_id, limit, show_disabled_showings, 
    					include_distinct_movies_in_header, 
    					include_empty_slots_for_movie_of_length);
    	
    	List<Showing> ungroupedShowings = ungroupedShowingsResponseEntity.getBody();

		
		Function<Showing, String> pickOutOnlyDateStringFromShowingDateTime = showing -> showing.getShowDateTime().toLocalDate().toString();
		
		Map<String,List<Showing>> scheduleByDate = 
				ungroupedShowings.stream()
				.collect(Collectors.groupingBy(pickOutOnlyDateStringFromShowingDateTime));
		
		// sort
		TreeMap<String,List<Showing>> sortedScheduleByDate = new TreeMap<String,List<Showing>>(scheduleByDate);		

        
		HttpHeaders ungroupedShowingsHttpHeaders = ungroupedShowingsResponseEntity.getHeaders();
		ResponseEntity<? extends Object> scheduleReponseEntity = 
				ResponseEntity.ok().headers(ungroupedShowingsHttpHeaders).body(group_by_theater ? groupShowingsByTheater(sortedScheduleByDate) : sortedScheduleByDate);
		
        return scheduleReponseEntity;
    }

	private Map<String, Map<String, List<Showing>>> groupShowingsByTheater(
			TreeMap<String, List<Showing>> sortedScheduleByDate) {
		Map<String,Map<String,List<Showing>>> scheuduleByDateAndTheaterName = new TreeMap<String,Map<String,List<Showing>>>();
		
		Function<Showing, String> pickOutTheaterNameFromShowing = showing -> showing.getTheater().getName();
		
		sortedScheduleByDate.forEach((dateString, listOfShowings) -> {
			Map<String, List<Showing>> showingsForSpecificDateGroupedByTheater = 
					listOfShowings.stream()
					.sorted()
					.collect(Collectors.groupingBy(pickOutTheaterNameFromShowing));
			// sort map (list in map is already sorted)
			TreeMap<String, List<Showing>> sortedShowingsForSpecificDateGroupedByTheater = 
					new TreeMap<String, List<Showing>>(showingsForSpecificDateGroupedByTheater);
			scheuduleByDateAndTheaterName.put(dateString, sortedShowingsForSpecificDateGroupedByTheater);
		});
		return scheuduleByDateAndTheaterName;
	}
    
    
    private HttpHeaders buildCustomHeadersForReadAll(List<Showing> showings) throws JsonProcessingException {
    	
    	HttpHeaders httpHeaders = new HttpHeaders();
    	httpHeaders.setContentType(MediaType.APPLICATION_JSON_UTF8);
    	
    	List<Movie> distinctMovies = getDistinctMovieListForShowings(showings);

		httpHeaders.add("distinct_movies", new ObjectMapper().writeValueAsString(distinctMovies));
		httpHeaders.add("Status Code", "200 OK");

    	return httpHeaders;
    }
    
    
    private List<Movie> getDistinctMovieListForShowings(List<Showing> showings) {
    	
    	List<Movie> movies = 
    			showings.stream()
    			.map(showing -> showing.getMovie())
    			.distinct()
    			.collect(Collectors.toList());
    			
    	return movies;
    }
   
    private void markBookingStatusForSeats(Showing retrievedShowing) {
    	Theater theater = retrievedShowing.getTheater();
    	
    	List<Seat> allBookedSeats = retrievedShowing.getBookings().stream()
    			.flatMap(booking -> booking.getBookedSeats().stream())
    			.distinct()
    			.collect(Collectors.toList());
    	
    	List<Seat> allSeats = theater.getRows().stream()
    			.flatMap(row -> row.getSeats().stream())
    			.collect(Collectors.toList());
    	
    	// set default to false
    	allSeats.forEach(seat -> seat.setIsBookedForShowing(false));
    	
    	allSeats.forEach(seat -> {
    		if(allBookedSeats.contains(seat)) {
    			seat.setIsBookedForShowing(true);
    		}
    	});
    }

}
