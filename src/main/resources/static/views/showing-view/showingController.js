
angular.module('filmr')
    .controller('showingController',
        ['$location', '$rootScope', '$scope', '$routeParams', '$resource', '$log', 'CinemaService', 'ShowingService',
            function ($location, $rootScope, $scope, $routeParams, $resource, $log, CinemaService, ShowingService) {

            //Publicly accessible variables
            $scope.moviesInRepertoire = [];
            $scope.theatersInCinema = [];
            $scope.allShowings = [];
            $scope.allCinemas = [];
            $scope.theater = {};
            $scope.movie = {};
            $scope.movieForShowing = {};

            //Execute on page load
            fetchCinemas(function(){
                $scope.cinema = $scope.allCinemas[0];
                fetchTheatersAndRepertoireInCinema();
                fetchShowingsWithParams();
            });

            //Publicly accessible functions
            $scope.fetchShowings = function() {
                $log.info("---");
                $log.info("fetch showings");
                fetchShowingsWithParams();
            }

            $scope.fetchCinemaScope = function() {
                $log.info("---");
                $log.info("fetch cinema scope");
                fetchTheatersAndRepertoireInCinema();
                fetchShowingsWithParams();
            }

            $scope.disableShowing = function (showing) {
                $log.info("---");
                $log.info("disable showing");
                $log.info("Try disable showing with id: " + showing.id);
                showing.isDisabled = !showing.isDisabled;

                ShowingService.update(showing).$promise.then(
                    function (result) {
                        $log.info("success!");
                        fetchShowingsWithParams();
                    },
                    function (error) {
                        $log.warn("failed!");
                        $rootScope.errorHandler(error);
                        //Reset value of isDisabled for correct representation in gui
                        showing.isDisabled = !showing.isDisabled;
                    }
                );
            }

            $scope.validateCreateShowing = function() {
                if(typeof $scope.movieForShowing != "object") return false;
                if(typeof $scope.theaterForShowing != "object") return false;
                if(typeof $scope.dateForShowing != "string") return false;
                if(!(typeof $scope.price == "number" || typeof $scope.price == "undefined" || $scope.price===null)) return false;
                if(typeof $scope.price == "number" && $scope.price<0) return false;
                if(typeof $scope.price == "number" && $scope.price>8192) return false;
                return true;
            }

            $scope.createShowing = function() {
                $log.info("---");
                $log.info("create showing");

                $rootScope.clearAlerts();

                if(!$scope.validateCreateShowing()) {
                    $rootScope.genericError();
                    $log.warn("showing not validated");
                    return;
                }

                var newShowing = new ShowingService();
                newShowing.movie = $scope.movieForShowing;
                newShowing.theater =$scope.theaterForShowing;
                newShowing.showDateTime = parseDateStringToValidAPIDateString($scope.dateForShowing);
                newShowing.price = $scope.price;
                newShowing.isDisabled = false;
                console.log("Date is: "+newShowing.showDateTime);

                ShowingService.save(newShowing, function (result) {
                        $rootScope.alert("Success! ","Showing added",1);
                        fetchShowingsWithParams();
                    },
                    function (error) {
                        if(error.data && error.data.exception=="filmr.helpers.exceptions.FilmrTimeOccupiedException") {
                            $rootScope.alert("Error! ","Time is already occupied",2);
                        }
                        else $rootScope.errorHandler(error);
                    });
            };

            $scope.clearAllFilters = function() {
                $log.info("---");
                $log.info("clear all filters");
                $scope.fromDate = null;
                $scope.toDate = null;
                $scope.movie = {};
                $scope.theater = {};
                $scope.showingIsDisabled = false;
                fetchShowingsWithParams();
            }

            function fetchCinemas(callbackWhenDone) {
                $log.info("---");
                $log.info("fetch cinemas");
                CinemaService.query().$promise.then(
                    function(result) {
                        $scope.allCinemas = result;
                        callbackWhenDone();
                    }
                )
            }

            function fetchTheatersAndRepertoireInCinema() {
                $log.info("---");
                $log.info("fetch theaters and repertoire in cinema");
                if(!$scope.cinema) throw "cinema is not set";

                $scope.moviesInRepertoire = $scope.cinema.repertoire.movies;
                $scope.theatersInCinema = $scope.cinema.theaters;
            }

            function fetchShowingsWithParams(){

                $log.info("---");
                $log.info("fetch showings with params");

                var params = Object();
                if($scope.cinema) params.only_for_cinema_with_id = $scope.cinema.id;
                if($scope.theater) params.only_for_theater_with_id = $scope.theater.id;
                if($scope.movie) params.only_for_movie_with_id = $scope.movie.id;
                if($scope.fromDate) params.from_date = parseDateStringToValidAPIDateString($scope.fromDate)
                if($scope.toDate) params.to_date = parseDateStringToValidAPIDateString($scope.toDate);
                if($scope.showingIsDisabled) params.show_disabled_showings = $scope.showingIsDisabled;
                if($scope.movieForShowing) params.include_empty_slots_for_movie_of_length = $scope.movieForShowing.lengthInMinutes;


                $log.debug("params:");
                $log.debug(params);

                ShowingService.query(params).$promise.then(
                    function (result){
                        console.log("in showings with params");
                        console.log(result);
                        $scope.allShowings = result;
                    },
                    function (error) {
                        $rootScope.errorHandler(error);
                    }
                )
            }

            var parseDateStringToValidAPIDateString = function(f) {
                $log.debug("---");
                $log.debug("parse date string to valid API date string");
                if(!f) return "";
                var r = f.substr(0,4+3+3);
                r += "T";
                r += f.substr(8+3);
                $log.debug(""+f+"->"+r);
                return r;
            }

        }]);
