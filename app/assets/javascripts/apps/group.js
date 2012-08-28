var module = angular.module("userGroup", ["global", "GamesSchedule", "Group.filters", "Group.services", "Group.directives"]);

module.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when("/one", {template: "one"});
  $routeProvider.when("/two", {template: "two"});
  $routeProvider.when("/three", {templateUrl:  "<%= asset_path 'blank.html' %>"});
  $routeProvider.otherwise({redirectTo: "/one"});
}]);
