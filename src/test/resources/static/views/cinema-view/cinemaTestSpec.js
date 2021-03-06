describe("cinemaController.js", function () {

    //Specify module
    beforeEach(module('filmr'));

    // Mocked data
    var mockedSavedTheater = null;
    var mockedMoviesInRepertoire = [
        {name: "Lion king"},
        {name: "Lion queen"},
        {name: "Alien"}
    ];
    var mockedRepertoire = {
        movies: mockedMoviesInRepertoire
    };
    var mockedAddableMovies = [
        {name: "Mars Attacks"},
        {name: "Deer Hunter"}
    ];
    var mockedTheaters = [
        {name: "sal01"},
        {name: "sal02"}
    ];
    var mockedCinema = {id: 1, name: "Lasses Biograf", repertoire: {id: 567}};
    var mockedRepetoireUpdateSuccessResult = {movies: [{name: 'Lion king'}, {name: 'Lion queen'}, {name: 'Alien'}, {name: 'Mars Attacks'}]};
    var mockedAddableMoviesAfterRepertoireUpdate = {movies: [{name: 'Lion queen'}, {name: 'Alien'}, {name: 'Mars Attacks'}]};

    // Save mocked events tracker
    var mockedLastUpdateRepertoirHeader = null;
    var mockedLastUpdateRepertoirBody = null;

    //Mocked services
    beforeEach(function () {

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
            'save': function (params, params2) {
                return {
                    '$promise': {
                        then: function (success, fail) {

                            if (params && params2) {
                                success();
                                mockedSavedTheater = [params, params2]
                            } else {
                                fail();
                            }
                        }
                    }
                }
            }
        };


        MockedMovieService = {
            'query': function (params) {
                return {
                    '$promise': {
                        then: function (success, fail) {

                            expect(params.not_in_repertoire_with_id).toBe(mockedCinema.repertoire.id)
                            success(mockedAddableMovies);
                        }
                    }
                }
            }
        };

        MockedRepertoireService = {
            'get': function () {
                return {
                    '$promise': {
                        then: function (success, fail) {
                            success(mockedRepertoire);
                        }
                    }
                }
            },
            'update': function (header, body) {
                return {
                    '$promise': {
                        then: function (success, fail) {
                            mockedLastUpdateRepertoirHeader = header;
                            mockedLastUpdateRepertoirBody = body;
                            mockedAddableMovies = mockedAddableMoviesAfterRepertoireUpdate;
                            success(mockedRepetoireUpdateSuccessResult);
                        }
                    }
                }
            }
        };

        MockedCinemaService = {
            'get': function () {
                return {
                    '$promise': {
                        then: function (success, fail) {
                            success(mockedCinema);
                        }
                    }
                }
            }
        };

        Mocked$routeParams = {
            'id': 1
        };

    });

    //Injections, defining which mocked services to use instead of the real ones
    beforeEach(inject(function (_$controller_) {
        $controller = _$controller_;
        $scope = {};
        Mocked$rootScope = {
            "alert": function () {
            }, "genericError": function () {
                Mocked$rootScope.alert("Error!")
            }, "errorHandler": function () {
            }
        };
        $controller('cinemaController', {
            $scope: $scope, $rootScope: Mocked$rootScope, $routeParams: Mocked$routeParams,
            MovieService: MockedMovieService, TheaterService: MockedTheaterService,
            RepertoireService: MockedRepertoireService, CinemaService: MockedCinemaService
        });
    }));

    /* Test specifications */

    // Repertoire tests
    describe("Repertoire", function () {

        it("Check getter for all movies in repertoires is working on start", function () {
            expect($scope.getMoviesInRepertoire()).toEqual(mockedMoviesInRepertoire);
        });

        it("Check getter for all movies that can be addable to repertoire is working on start", function () {
            expect($scope.getAddableMovies()).toEqual(mockedAddableMovies);
        });

        it("Check save is called with correct params when add movie to repertoire (both movies-in-repertoire and movies-can-be-added must be refreshed after call)", function () {
            $scope.add_movie_to_repertoire_select = {id: 123, name: "Mars Attacks"};
            $scope.addMovieToRepertoire();

            expect(mockedLastUpdateRepertoirHeader).toEqual({"id": 567, "add_movie_with_id": 123});
            expect(mockedLastUpdateRepertoirBody).toEqual({"id": 567});

            expect($scope.getMoviesInRepertoire()).toEqual(mockedRepetoireUpdateSuccessResult.movies);
            expect($scope.getAddableMovies()).toEqual(mockedAddableMoviesAfterRepertoireUpdate);
        });

        it("Check remove movie from repertoire (both movies-in-repertoire and movies-can-be-added must be refreshed after call)", function () {
            $scope.removeMovieFromRepertoire(178);

            expect(mockedLastUpdateRepertoirHeader).toEqual({"id": 567, "remove_movie_with_id": 178});
            expect(mockedLastUpdateRepertoirBody).toEqual({"id": 567});

            expect($scope.getMoviesInRepertoire()).toEqual(mockedRepetoireUpdateSuccessResult.movies); //note/confusing: the mockedRepetoireUpdateSuccessResult is based on a list of added movies. The same list work here since we are just compareing(toEqual) and mocked service do not actual modify list in a correct way
            expect($scope.getAddableMovies()).toEqual(mockedAddableMoviesAfterRepertoireUpdate);
        });

    });

    // Theater tests
    describe("Theaters", function () {
        it("Gets all theaters", function () {
            expect($scope.getTheaters()).toEqual(mockedTheaters);
        });

        it("Gets the id of the current cinema", function () {
            expect($scope.getCurrentCinemaId()).toEqual(1);
        });

        it("Stores the theater data in an object when submit is clicked", function () {
            $scope.theater_name = "sal03";
            $scope.number_of_rows = 12;
            $scope.number_of_seats = 12;


            $scope.addNewTheater();

            expect($scope.newTheater.name).toBe("sal03");
            expect($scope.newTheater.cinema.id).toEqual(1);
        });

        it("Sends the theater object to the API via POST", function () {
            $scope.theater_name = "sal03";
            $scope.number_of_rows = 12;
            $scope.number_of_seats = 12;
            $scope.addNewTheater();

            expect(mockedSavedTheater).toEqual([Object({number_of_rows: 12, max_row_size: 12}), Object({
                name: 'sal03',
                cinema: Object({id: 1})
            })]);
        });


        it("Logs a success message if the add theater-API call is successful", function () {
            spyOn(Mocked$rootScope, 'alert');

            $scope.theater_name = "sal03";
            $scope.number_of_rows = 12;
            $scope.number_of_seats = 12;
            $scope.addNewTheater();

            expect(Mocked$rootScope.alert).toHaveBeenCalledWith('Success! ', 'Theater sal03 was created', 1);
        });

        it("Logs an error message if the add theater-API call is unsuccessful", function () {
            spyOn(Mocked$rootScope, 'alert');
            $scope.addNewTheater();

            expect(Mocked$rootScope.alert).toHaveBeenCalledWith('Error!');
        });

        it("Resets the input fields after add theater", function () {
            $scope.resetFields();

            expect($scope.add_theater_name).toEqual("");
            expect($scope.add_theater_disabled).toEqual(false);
            expect($scope.add_theater_seats).toEqual(0);

        })
    });

    //Cinema test
    describe("Cinema", function () {
        it("Prints the cinema name", function () {
            expect($scope.cinema_name).toEqual($scope.getCurrentCinema().name);
        });

        it("Disables the submit button if cinema name is empty", function () {
            $scope.edited_cinema_name = "";
            expect($scope.validateCinemaNameForm()).toEqual(false);
            $scope.edited_cinema_name = "Wololo";
            expect($scope.validateCinemaNameForm()).toEqual(true);
        });
    });
});
