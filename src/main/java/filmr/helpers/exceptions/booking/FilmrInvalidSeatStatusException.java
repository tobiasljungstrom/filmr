package filmr.helpers.exceptions.booking;

import filmr.helpers.exceptions.FilmrBaseException;
import filmr.helpers.exceptions.FilmrErrorCode;

public class FilmrInvalidSeatStatusException extends FilmrBaseException {
	
	private static final long serialVersionUID = 9073383609659067467L;

	public FilmrInvalidSeatStatusException(String msg) {
		super(msg, FilmrErrorCode.F410);
	}

}
