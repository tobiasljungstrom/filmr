package filmr.controllers;

import filmr.domain.Theater;
import filmr.helpers.exceptions.FilmrBaseException;
import filmr.helpers.exceptions.FilmrExceptionModel;
import filmr.helpers.exceptions.FilmrPOSTRequestWithPredefinedIdException;
import filmr.helpers.exceptions.FilmrPUTRequestWithMissingEntityIdException;
import filmr.services.TheaterService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping(value = "/api/theaters")
public class TheaterController {

	private final static org.apache.log4j.Logger logger = Logger.getLogger(TheaterController.class);
	@Autowired
	private TheaterService theaterService;

	@CrossOrigin
	@RequestMapping(method = RequestMethod.POST)
	public ResponseEntity<Theater> createTheater(
			@RequestBody Theater theater,
			@RequestParam(name="number_of_rows") Integer number_of_rows,
			@RequestParam(name="max_row_size") Integer max_row_size) throws FilmrPOSTRequestWithPredefinedIdException {

		if (theater.getId() != null) throw new FilmrPOSTRequestWithPredefinedIdException("Trying to create Theater but entity already has a set id.");
		
		logger.debug("Theater (before save) received in createTheater: " + theater);
		logger.debug(String.format("Creating theater with number_of_rows = %d, max_row_size  = %d ", number_of_rows, max_row_size));
		
		theater = theaterService.buildTheaterWithRowsAndSeats(theater,number_of_rows,max_row_size);
		Theater savedTheater = theaterService.saveEntity(theater);
		return new ResponseEntity<Theater>(savedTheater, HttpStatus.OK);
	}

	@CrossOrigin
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Theater> readTheater(@PathVariable Long id) {
		Theater retrievedTheater = theaterService.readEntity(id);
		return new ResponseEntity<Theater>(retrievedTheater, HttpStatus.OK);
	}

	@CrossOrigin
	@RequestMapping(method = RequestMethod.GET)
	public ResponseEntity<List<Theater>> readAllTheaters(@RequestParam(name = "cinema_id", required = false) Long cinema_id) {


		List<Theater> retrievedTheaters;
		if (cinema_id != null) {
			logger.info("Retrieving theaters belonging to cinema " + cinema_id);
			retrievedTheaters = theaterService.readfilteredEntries(cinema_id);
		} else {
			logger.info("Retrieving all cinemas");
			retrievedTheaters = theaterService.readAllEntities();
		}

		return new ResponseEntity<List<Theater>>(retrievedTheaters, HttpStatus.OK);
	}


	@CrossOrigin
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public ResponseEntity<Theater> updateTheater(
			@PathVariable Long id, 
			@RequestBody Theater theater,
			@RequestParam(name="reset_seat_numbers_for_each_row", defaultValue="true", required=false) Boolean reset_seat_numbers_for_each_row,
			@RequestParam(name="new_number_of_rows", required = false) Integer new_number_of_rows,
			@RequestParam(name="new_max_row_size", required = false) Integer new_max_row_size) throws FilmrPUTRequestWithMissingEntityIdException{

		if(theater.getId() == null) throw new FilmrPUTRequestWithMissingEntityIdException("Trying to update Theater but it has no id set.");

		// Temporary(?) fix for issue with theater losing rows on update, because @JsonIgnore means some two-way connections are missing after deserialization
		theater.getRows().forEach(row -> {
			row.setTheater(theater);	
			row.getSeats().forEach(seat -> seat.setRow(row));
		});
		
		logger.debug("theater row size before update: " + theater.getRows().size());

		// set default arguments if any of the parameters are null
		new_number_of_rows = new_number_of_rows != null ? new_number_of_rows : theater.getRows().size();
		new_max_row_size = new_max_row_size != null ? new_max_row_size : theater.getRows().get(0).getSeats().size();
		
		logger.debug("theater update with 'new_number_of_rows' = " + new_number_of_rows + " and 'new_max_row_size' = " + new_max_row_size);
		
		theaterService.updateRowsAndSeats(theater, new_number_of_rows, new_max_row_size);
		
		logger.debug("theater row size after update: " + theater.getRows().size());
		
		//TODO: deletion of seats doesn't work. is that ok? they can be set to SeatState.NOT_A_SEAT
		
		theaterService.nameRowsAndSeats(theater, reset_seat_numbers_for_each_row);

		Theater updatedTheater = theaterService.saveEntity(theater);
		return new ResponseEntity<Theater>(updatedTheater, HttpStatus.OK);
	}

	@CrossOrigin
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public ResponseEntity deleteTheater(@PathVariable Long id) {
		theaterService.deleteEntity(id);
		return new ResponseEntity(HttpStatus.OK);
	}
	
	// all custom errors should inherit from FilmrBaseException, so this should work for all of them. 
    @ExceptionHandler(FilmrBaseException.class)
    @ResponseBody
    public ResponseEntity<FilmrExceptionModel> handleBadRequest(HttpServletRequest req, FilmrBaseException ex) {
    	logger.debug("Catching custom error in controller.. ");
    	FilmrExceptionModel exceptionModel = new FilmrExceptionModel(req, ex);
        return new ResponseEntity<FilmrExceptionModel>(exceptionModel, ex.getHttpStatus());
    } 

}
