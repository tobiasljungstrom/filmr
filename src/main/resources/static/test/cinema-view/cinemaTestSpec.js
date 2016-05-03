describe("cinemaController.js", function () {

	beforeEach(module('filmr'));

	beforeEach(function () {


		MockedMovieService = {
			'query': function (params) {
				return {
					'$promise': {
						then: function (success, fail) {
							success(mockedAddableMovies);
						}
					}
				}
			},
			'save': function (params) {
				return {
					'$promise': {
						then: function (success, fail) {
							if (typeof params != 'undefined') {
								success();
								mockedSavedCinema = params;
							} else {
								fail();
							}
						}
					}
				}
			}
		};

		MockedTheaterService = {
			'query': function (params) {
				return {
					'$promise': {
						then: function (success, fail) {
							success(mockedTheaters);
						}
					}
				}
			},
			'save': function (params) {
				return {
					'$promise': {
						then: function (success, fail) {
							if (params.name && params.numberOfSeats && params.cinemaId) {
								success();
								mockedSavedTheater = params;
							} else {
								fail();
							}
						}
					}
				}
			}
		};
		MockedRepertoireService = {};
		MockedCinemaService = {
			'query': function (params) {
				return {
					'$promise': {
						then: function (success, fail) {
							success(mockedCinemas);
						}
					}
				}
			},
			'save': function (params) {
				return {
					'$promise': {
						then: function (success, fail) {
							if (typeof params != 'undefined') {
								success();
								mockedSavedCinema = params;
							} else {
								fail();
							}
						}
					}
				}
			}
		};

	});

	//Injections
	beforeEach(inject(function (_$controller_) {
		$controller = _$controller_;
		$scope = {};
		$routeParamsStub = {id: 1};

		$controller('cinemaController', {
			$scope: $scope,
			$routeParams: {id: 1},
			MovieService: MockedMovieService,
			TheaterService: MockedTheaterService,
			RepertoireService: MockedRepertoireService,
			CinemaService: MockedCinemaService
		});
	}));


	// MOCKS

	var mockedSavedTheater = {};


	var mockedMoviesInRepertoire = [
		{name: "Lion king"},
		{name: "Lion queen"},
		{name: "Alien"}
	];

	var mockedAddableMovies = [
		{name: "Mars Attacks"},
		{name: "Deer Hunter"}
	];

	var mockedTheaters = [
		{name: "sal01"},
		{name: "sal02"}
	];

	//TESTS


	//  - movies / repertoire
	describe("Repertoire", function () {
		/*


		 it("Check getter for all movies in repertoire is working on start", function(){
		 expect($scope.getMoviesInRepertoire()).toEqual(mockedMoviesInRepertoire);
		 });

		 it("Check getter for all movies that can be addable to repertoire is working on start", function(){
		 expect($scope.getAddableMovies()).toEqual(mockedAddableMovies);
		 });


		 it("Check save is called with correct params when add movie to repertoire (both movies-in-repertoire and movies-can-be-added must be refreshed after call)", function(){
		 $scope.add_movie_to_repetoire_select = {name:"Mars Attacks"};
		 $scope.addMovieToRepertoire();

		 expect(mockedSavedRepertoire).toEqual([{name: "Lion king"},{name: "Lion queen"},{name: "Alien"},{name:"Mars Attacks"}]);
		 expect($scope.getMoviesInRepertoire()).toEqual([{name: "Lion king"},{name: "Lion queen"},{name: "Alien"},{name:"Mars Attacks"}]);
		 expect($scope.getAddableMovies()).toEqual([{name:"Deer Hunter"}]);

		 });

		 it("Check remove movie from repertoire (both movies-in-repertoire and movies-can-be-added must be refreshed after call)", function(){
		 $scope.removeMovieFromRepertoire({name: "Alien"});

		 expect(mockedSavedRepertoire).toEqual([{name: "Lion king"},{name: "Lion queen"}]);
		 expect($scope.getMoviesInRepertoire()).toEqual([{name: "Lion king"},{name: "Lion queen"}]);
		 expect($scope.getAddableMovies()).toEqual([{name:"Mars Attacks"},{name:"Deer Hunter"},{name:"Alien"}]);

		 });
		 */
	});


	//  - theaters

	describe("Theaters", function () {
		it("Gets all theaters", function () {
			expect($scope.getTheaters()).toEqual(mockedTheaters);
		});

		it("Gets the id of the current cinema", function () {
			expect($scope.getCurrentCinemaId()).toEqual(1);
		});

		it("Stores the theater data in an object when submit is clicked", function () {
			$scope.add_theater_name = "sal03";
			$scope.add_theater_seats = 100;

			expect($scope.add_theater_disabled).toBeUndefined();

			$scope.submitTheater();

			expect($scope.newTheater.name).toBe("sal03");
			expect($scope.newTheater.disabled).toBe(false);
			expect($scope.newTheater.numberOfSeats).toBe(100);
			expect($scope.newTheater.cinemaId).toEqual(1);
		});

		it("Sends the theater object to the API via POST", function () {
			$scope.add_theater_name = "sal04";
			$scope.add_theater_seats = 100;
			$scope.add_theater_disabled = false;
			$scope.submitTheater();

			expect(mockedSavedTheater).toEqual({cinemaId: 1, name: "sal04", disabled: false, numberOfSeats: 100});
		});


		it("Logs a success message if the add theater-API call is successful", function () {
			spyOn($scope, 'alert');

			$scope.add_theater_name = "sal04";
			$scope.add_theater_seats = 100;
			$scope.add_theater_disabled = false;
			$scope.submitTheater();

			expect($scope.alert).toHaveBeenCalledWith("Success!");
		});

		it("Logs an error message if the add theater-API call is unsuccessful", function () {
			spyOn($scope, 'alert');
			$scope.submitTheater();

			expect($scope.alert).toHaveBeenCalledWith("Error!");

		});

		it("Resets the input fields after add theater", function () {
			$scope.resetFields();

			expect($scope.add_theater_name).toEqual("");
			expect($scope.add_theater_disabled).toEqual(false);
			expect($scope.add_theater_seats).toEqual(0);

		})
	});


});
