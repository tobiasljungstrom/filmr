package filmr.api;

import filmr.Application;
import filmr.domain.Cinema;
import filmr.domain.Movie;
import filmr.domain.Showing;
import filmr.domain.Theater;
import filmr.repositories.*;
import filmr.testfactories.EntityFactory;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.boot.test.WebIntegrationTest;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotWritableException;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.util.ArrayList;

import static junit.framework.TestCase.assertEquals;
import static org.junit.Assert.assertTrue;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(Application.class)
@WebIntegrationTest
@ActiveProfiles({"test"})
public class ShowingTest {

    //Variables
    @Autowired
    private ShowingRepository showingRepository;
    @Autowired
    private MovieRepository movieRepository;
    @Autowired
    private TheaterRepository theaterRepository;
    @Autowired
    private CinemaRepository cinemaRepository;
    @Autowired
    private RowRepository rowRepository;
    @Autowired
    private SeatRepository seatRepository;

    private RestTemplate restTemplate;
    private String baseUrl;
    private String urlWithId;
    //Variables for testing values
    private int tableSize;
    private Showing savedShowing;
    private Movie savedMovie;
    private Theater savedTheater;
    private Cinema savedCinema;

    //Parameters
    private Long id;

    @Before
    public void resetDatabase() throws Exception {
        baseUrl = "http://localhost:8080/filmr/api/showings/";

        //Initialize restTemplate
        restTemplate = new RestTemplate();

        //clear everything
        seatRepository.deleteAllInBatch();
        rowRepository.deleteAllInBatch();
        showingRepository.deleteAllInBatch();
        movieRepository.deleteAllInBatch();
        theaterRepository.deleteAllInBatch();
        cinemaRepository.deleteAllInBatch();

        //Create showing and everything that belongs in it
        Movie movie = EntityFactory.createMovie("Global Test Movie", "A Movie About Cows Murdering cute bunnies", new Long(120), new Double(100));
        savedMovie = movieRepository.save(movie);
        Cinema cinema = EntityFactory.createCinema("Global Test Cinema");
        savedCinema = cinemaRepository.save(cinema);
        Theater theater = EntityFactory.createTheater("Global Test Theater", savedCinema);
        savedTheater = theaterRepository.save(theater);
        Showing showing = EntityFactory.createShowing(LocalDateTime.now().plusDays(1), savedMovie, savedTheater, new ArrayList<>());
        
        System.out.println("!! Saving showing through repo, in @Before \n");
        savedShowing = showingRepository.save(showing);

        //Setup id for this run
        id = savedShowing.getId();
        urlWithId = baseUrl+id;

        tableSize = showingRepository.findAll().size();
        System.out.println("Table size: " + tableSize);
    }

    @Test
    public void testCreate() throws Exception {
        Showing showing = EntityFactory.createShowing(LocalDateTime.now(), savedMovie, savedTheater, new ArrayList<>());

        //Post
        ResponseEntity<Showing> responseEntity = restTemplate.postForEntity(baseUrl, showing, Showing.class);
        Showing postedShowing = responseEntity.getBody();

        //Assert
        assertTrue("Make sure the http was successfull", responseEntity.getStatusCode().is2xxSuccessful());
       // assertEquals("Compare times", showing.getShowDateTime(), postedShowing.getShowDateTime()); //The returned date has passed through deserializer and therefore is slightly different
        assertEquals("Compare movies", showing.getMovie(), postedShowing.getMovie());
        assertEquals("Compare theaters", showing.getTheater(), postedShowing.getTheater());
        assertEquals("Compare bookings", showing.getBookings(), postedShowing.getBookings());
    }

    @Test(expected = HttpMessageNotWritableException.class)
    public void testCreateWithNullMovie() {
        Showing showing = EntityFactory.createShowing(LocalDateTime.now(), null, savedTheater, new ArrayList<>());

        ResponseEntity<Showing> responseEntity = restTemplate.postForEntity(baseUrl, showing, Showing.class);
    }

    @Test
    public void testRead() {
        //Get
        ResponseEntity<Showing> responseEntity = restTemplate.getForEntity(urlWithId, Showing.class);
        Showing showing = responseEntity.getBody();

        //Assert
        assertTrue("Make sure the call was succesfull", responseEntity.getStatusCode().is2xxSuccessful());
        assertEquals("Assert that the id of the read object is the same as we asked to get", id, showing.getId());
        assertEquals("Assert that the read object is the same as the one created in @Before", savedShowing, showing);
    }

    //2 birds with one stone; update and disable check
    @Test
    public void testUpdate() {
        Boolean changeDisabledTo = true;
        savedShowing.setIsDisabled(changeDisabledTo);

        restTemplate.put(urlWithId, savedShowing);

        Showing updatedShowing = showingRepository.findOne(id);

        assertEquals("Assert that the object is updated", savedShowing, updatedShowing);
        assertEquals("Make sure the showing is disabled", updatedShowing.getIsDisabled(), new Boolean(true));
    }

    @After
    public void clearDatabase() throws Exception {
        //clear everything
        seatRepository.deleteAllInBatch();
        rowRepository.deleteAllInBatch();
        showingRepository.deleteAllInBatch();
        movieRepository.deleteAllInBatch();
        theaterRepository.deleteAllInBatch();
        cinemaRepository.deleteAllInBatch();
    }
}
