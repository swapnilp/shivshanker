var module = angular.module("Invite.services", ["ngResource"]);

module.factory('User', function($resource) {
  var r = $resource('/users/:id', {}, {
    get: {method:'GET'}
  });

  return r;
});
