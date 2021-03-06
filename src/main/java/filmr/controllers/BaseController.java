package filmr.controllers;

import filmr.helpers.exceptions.FilmrBaseException;
import filmr.helpers.exceptions.FilmrExceptionModel;
import filmr.helpers.exceptions.FilmrInvalidDateFormatException;
import org.apache.log4j.Logger;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import javax.servlet.http.HttpServletRequest;

/**
 * 
 * Provides shared logging capabilities and error handling for Filmr custom errors 
 * for all controllers extending the class. 
 *
 */
public class BaseController {
	
	protected org.apache.log4j.Logger logger = Logger.getLogger(this.getClass());
	
    // all custom errors should inherit from FilmrBaseException, so this should work for all of them.
    @ExceptionHandler(FilmrBaseException.class)
    @ResponseBody
    public ResponseEntity<FilmrExceptionModel> handleBadRequest(HttpServletRequest req, FilmrBaseException ex) {
    	logger.debug("Catching custom error in method inherrited from BaseController.java ", ex);
    	FilmrExceptionModel exceptionModel = new FilmrExceptionModel(req, ex);
        return new ResponseEntity<FilmrExceptionModel>(exceptionModel, ex.getHttpStatus());
    }

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ResponseEntity<FilmrExceptionModel> handleBadDateTimeFormat(HttpServletRequest req, Exception ex) throws Exception {
    	
    	logger.debug("caught non-custom exception: " + ex);
    	logger.debug("caught non-custom exception with message : " + ex.getLocalizedMessage());
    	
    	if(ex.getLocalizedMessage().contains("java.time.format.DateTimeParseException")) {
    		// something wrong with the date format
    		logger.debug("caught probable datetime format exception: " + ex);
    		FilmrInvalidDateFormatException datetimeException = new FilmrInvalidDateFormatException();
    		FilmrExceptionModel exceptionModel = new FilmrExceptionModel(req, datetimeException);
    		return new ResponseEntity<FilmrExceptionModel>(exceptionModel, datetimeException.getHttpStatus());    		
    	}
    	
    	// else just throw the error and let Spring handle it
    	throw ex;
    	
    }

}
