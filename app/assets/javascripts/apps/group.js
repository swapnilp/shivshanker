var module = angular.module("userGroup", ["global", "GamesSchedule", "Group.filters", "Group.services", "Group.directives"]);

module.config(['$routeProvider', function($routeProvider) {
	    $routeProvider.when("/add_user", {templateUrl: "<%= asset_path 'group/add_user.html' %>"});
	    $routeProvider.when("/update_group", {templateUrl: "<%= asset_path 'group/update_groups.html' %>"});
	    $routeProvider.otherwise({redirectTo: "/add_user"});
	}]);
