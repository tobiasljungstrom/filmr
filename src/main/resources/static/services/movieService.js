/**
 *  (some) CRUD operations for movies
 */
angular.module('filmr').factory('MovieService', ['$resource', '$rootScope', function($resource,$rootScope) {
	var moviesBaseUrl = $rootScope.API_baseUrl + "movies/";
	return $resource(moviesBaseUrl + ":id");
// end of service		
}]);
