package filmr.controllers;

import filmr.domain.Theater;
import filmr.services.TheaterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by Marco on 2016-04-25.
 */
@RestController
@RequestMapping(value = "/api/theaters")
public class TheaterController {
	@Autowired
	private TheaterService theaterService;

	@CrossOrigin
	@RequestMapping(method = RequestMethod.POST)
	public ResponseEntity<Theater> createTheater(@RequestBody Theater theater) {
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
	public ResponseEntity<List<Theater>> readAllMovies(@RequestParam(name = "cinema_id", required = false) Long cinema_id) {

		List<Theater> retrievedTheaters;

		if (cinema_id != null) {
			System.out.println("Retrieving theaters belonging to cinema " + cinema_id);
			retrievedTheaters = theaterService.readfilteredEntries(cinema_id);
		} else {
			System.out.println("Retrieving all cinemas");
			retrievedTheaters = theaterService.readAllEntities();
		}

		return new ResponseEntity<List<Theater>>(retrievedTheaters, HttpStatus.OK);
	}


	@CrossOrigin
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public ResponseEntity<Theater> updateTheater(@PathVariable Long id, @RequestBody Theater theater) {
		if (theater.getId() == null) {
			return new ResponseEntity<Theater>(new Theater(), HttpStatus.BAD_REQUEST);
		}

		Theater updatedTheater = theaterService.saveEntity(theater);
		return new ResponseEntity<Theater>(updatedTheater, HttpStatus.OK);
	}

	@CrossOrigin
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public ResponseEntity deleteTheater(@PathVariable Long id) {
		theaterService.deleteEntity(id);
		return new ResponseEntity(HttpStatus.OK);
	}

}
