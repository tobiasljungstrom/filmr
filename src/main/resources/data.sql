

/* THE CINEMA AND ITS REPERTOIRE */
INSERT INTO repertoire (id) VALUES(null);
INSERT INTO cinema (name,repertoire) VALUES('Lasses Biograf',1);
/* ANOTHER CINEMA WITH REPERTOIRE */
INSERT INTO repertoire (id) VALUES(null);
INSERT INTO cinema (name,repertoire) VALUES('Lisas Biograf',2);


/* MOVIES*/

INSERT INTO movie (title, length_in_minutes, description, default_price, trailer_url)
	VALUES ('The Lion King', 119, 'Story about lions', 65.00, '4sj1MT05lAA?t=10');

INSERT INTO movie (title, length_in_minutes, description, default_price, trailer_url)
	VALUES ('One Flew Over the Cuckoo\'s Nest', 133, 'A criminal pleads insanity after getting into trouble', 80, '2WSyJgydTsA');

INSERT INTO movie (title, length_in_minutes, description, default_price, trailer_url)
	VALUES ('Batman Returns', 126, 'When a corrupt businessman and the grotesque Penguin plot to take control of Gotham City', 60, 'Too3qgNaYBE');

INSERT INTO movie (title, length_in_minutes, description, default_price, trailer_url)
	VALUES ('The Cable Guy', 96, '-', 72.33, 'Xj259Pi_vrA');

INSERT INTO movie (title, length_in_minutes, description, default_price, trailer_url)
	VALUES ('Ferris Bueller\'s Day Off', 103, '-', 72.33, 'K-X2XzKqBiE');

INSERT INTO movie (title, length_in_minutes, description, default_price, trailer_url)
	VALUES ('The Da Vinci Code', 159, '-', 72.33, 'zMba3fckhuQ');

INSERT INTO movie (title, length_in_minutes, description, default_price, trailer_url)
	VALUES ('Alien', 117, '-', 72.33, 'LjLamj-b0I8');
	
/* THEATERS */

INSERT INTO theater (name, cinema_id, disabled, using_continuous_seat_labeling) VALUES ('Lasses Stora', 1, FALSE, b'1');
INSERT INTO theater (name, cinema_id, disabled, using_continuous_seat_labeling) VALUES ('Lasses Lilla', 1, FALSE, b'1');

INSERT INTO theater (name, cinema_id, disabled, using_continuous_seat_labeling) VALUES ('Sal 1', 2, FALSE, b'1');
INSERT INTO theater (name, cinema_id, disabled, using_continuous_seat_labeling) VALUES ('Sal 2', 2, FALSE, b'1');

/* ROWS AND SEATS */
INSERT INTO row (row_label, theater_id) VALUES ('Rad 1', 1);
INSERT INTO row (row_label, theater_id) VALUES ('Rad 2', 1);
INSERT INTO row (row_label, theater_id) VALUES ('Rad 3', 1);

INSERT INTO row (row_label, theater_id) VALUES ('Enda raden', 2);

INSERT INTO row (row_label, theater_id) VALUES ('Rad 1', 3);
INSERT INTO row (row_label, theater_id) VALUES ('Rad 2', 4);

INSERT INTO seat (seat_label, state, row_id) VALUES ('1', 'NOT_A_SEAT', 1);
INSERT INTO seat (seat_label, state, row_id) VALUES ('2', 'ENABLED', 1);
INSERT INTO seat (seat_label, state, row_id) VALUES ('3', 'ENABLED', 1);
INSERT INTO seat (seat_label, state, row_id) VALUES ('4', 'ENABLED', 1);
INSERT INTO seat (seat_label, state, row_id) VALUES ('5', 'ENABLED', 1);
INSERT INTO seat (seat_label, state, row_id) VALUES ('6', 'ENABLED', 1);
INSERT INTO seat (seat_label, state, row_id) VALUES ('7', 'ENABLED', 1);
INSERT INTO seat (seat_label, state, row_id) VALUES ('8', 'NOT_A_SEAT', 1);

INSERT INTO seat (seat_label, state, row_id) VALUES ('9', 'ENABLED', 2);
INSERT INTO seat (seat_label, state, row_id) VALUES ('10', 'ENABLED', 2);
INSERT INTO seat (seat_label, state, row_id) VALUES ('11', 'ENABLED', 2);
INSERT INTO seat (seat_label, state, row_id) VALUES ('12', 'ENABLED', 2);
INSERT INTO seat (seat_label, state, row_id) VALUES ('13', 'ENABLED', 2);
INSERT INTO seat (seat_label, state, row_id) VALUES ('14', 'ENABLED', 2);
INSERT INTO seat (seat_label, state, row_id) VALUES ('15', 'ENABLED', 2);
INSERT INTO seat (seat_label, state, row_id) VALUES ('16', 'ENABLED', 2);

INSERT INTO seat (seat_label, state, row_id) VALUES ('17', 'ENABLED', 3);
INSERT INTO seat (seat_label, state, row_id) VALUES ('18', 'ENABLED', 3);
INSERT INTO seat (seat_label, state, row_id) VALUES ('19', 'ENABLED', 3);
INSERT INTO seat (seat_label, state, row_id) VALUES ('20', 'ENABLED', 3);
INSERT INTO seat (seat_label, state, row_id) VALUES ('21', 'ENABLED', 3);
INSERT INTO seat (seat_label, state, row_id) VALUES ('22', 'ENABLED', 3);
INSERT INTO seat (seat_label, state, row_id) VALUES ('23', 'ENABLED', 3);
INSERT INTO seat (seat_label, state, row_id) VALUES ('24', 'ENABLED', 3);

INSERT INTO seat (seat_label, state, row_id) VALUES ('1', 'ENABLED', 4);
INSERT INTO seat (seat_label, state, row_id) VALUES ('2', 'ENABLED', 4);
INSERT INTO seat (seat_label, state, row_id) VALUES ('3', 'ENABLED', 4);
INSERT INTO seat (seat_label, state, row_id) VALUES ('4', 'ENABLED', 4);
INSERT INTO seat (seat_label, state, row_id) VALUES ('5', 'ENABLED', 4);

INSERT INTO seat (seat_label, state, row_id) VALUES ('1', 'ENABLED', 5);
INSERT INTO seat (seat_label, state, row_id) VALUES ('1', 'ENABLED', 6);




/* SHOWINGS */
/*# for movie 1, theater 1*/
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-12 12:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-12 15:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-12 19:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-12 21:00', 1, 1);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 12:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 15:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 19:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 21:00', 1, 1);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 12:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 15:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 19:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 21:00', 1, 1);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 12:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 15:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 19:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 21:00', 1, 1);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-17 12:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-17 15:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-17 19:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-17 21:00', 1, 1);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 12:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 15:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 19:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 21:00', 1, 1);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 12:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 15:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 19:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 21:00', 1, 1);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 12:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 15:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 19:00', 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 21:00', 1, 1);


/* for movie 2, theater 2*/
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 10:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 13:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 15:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 17:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 19:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 21:00', 2, 2);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 10:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 13:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 15:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 17:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 19:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 21:00', 2, 2);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 10:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 13:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 15:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 17:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 19:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 21:00', 2, 2);
                                                                            
/*                                                                          
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-07 10:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-07 13:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-07 15:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-07 17:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-07 19:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-07 21:00', 2, 2);
*/

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 10:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 13:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 15:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 17:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 19:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 21:00', 2, 2);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 10:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 13:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 15:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 17:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 19:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 21:00', 2, 2);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 10:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 13:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 15:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 17:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 19:00', 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 21:00', 2, 2);


/* for movie 3, theater 3 */
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 12:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 14:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 16:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-14 18:00', 3, 3);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 12:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 14:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 16:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-15 18:00', 3, 3);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 12:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 14:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 16:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-16 18:00', 3, 3);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-17 12:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-17 14:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-17 16:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-17 18:00', 3, 3);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 12:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 14:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 16:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-18 18:00', 3, 3);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 12:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 14:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 16:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-19 18:00', 3, 3);

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 12:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 14:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 16:00', 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES ('2016-05-20 18:00', 3, 3);


/* FILL REPETOIRE OF LASSES CINEMA WITH TWO MOVIES */
INSERT INTO repertoire_movies (repertoire,movies) VALUES(1,1);
INSERT INTO repertoire_movies (repertoire,movies) VALUES(1,2);

/* FILL REPETOIRE OF LISAS CINEMA WITH TWO MOVIES */
INSERT INTO repertoire_movies (repertoire,movies) VALUES(2,3);
INSERT INTO repertoire_movies (repertoire,movies) VALUES(2,4);


/* NEW DYNAMIC SHOWINGS */

/* SHOWINGS */
/*# for movie 1, theater 1*/
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 10:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 13:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 16:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 19:00'), 1, 1);

/*    these test data may break build, because they may generate invalid dates, like 2016-05-32 10:00                                                                
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 08:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 11:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 14:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 19:00'), 1, 1);
                                                                  
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 10:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 13:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 16:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 20:00'), 1, 1);
                                                                   
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 08:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 11:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 14:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 19:00'), 1, 1);
                                                                  
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 10:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 13:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 16:00'), 1, 1);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 19:00'), 1, 1);
*/
                                                                 
/* for movie 2, theater 2*/                                       
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 10:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 13:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 16:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 19:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 22:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 06:30'), 2, 2);

/*        these test data may break build, because they may generate invalid dates, like 2016-05-32 10:00                                                                  
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 10:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 13:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 16:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 19:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 22:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 06:30'), 2, 2);
                                                                  
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 10:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 13:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 16:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 19:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 22:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 06:30'), 2, 2);
                                                              

INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 10:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 13:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 16:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 19:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 21:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 23:30'), 2, 2);
                                                                   
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 10:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 13:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 16:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 19:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 22:00'), 2, 2);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 06:30'), 2, 2);
*/                                                                                                                    
                                                                   
/* for movie 3, theater 3 */                                     
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 08:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 11:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 14:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 0) , ' 19:00'), 3, 3);

/*     these test data may break build, because they may generate invalid dates, like 2016-05-32 10:00                                                              
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 08:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 11:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 14:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 1) , ' 19:00'), 3, 3);
                                                                  
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 08:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 11:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 14:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 2) , ' 19:00'), 3, 3);
                                                                  
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 08:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 11:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 14:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 3) , ' 19:00'), 3, 3);
                                                                  
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 08:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 11:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 14:00'), 3, 3);
INSERT INTO showing (show_date_time, movie_id, theater_id) VALUES (CONCAT(CONCAT(DATE_FORMAT(NOW(), '%Y-%m-'),  CAST(date_format(now(),'%d') AS UNSIGNED) + 4) , ' 19:00'), 3, 3);
*/
                                                                  
