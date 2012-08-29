function groupCtrl($scope, $http) {
    $scope.groups = [];
    $scope.groupUsers = [];
	
    $scope.fetch = function() {
	$http.get('groups').
	success(function( groups ) {
		$scope.groups = groups 
	    });
    };

    $scope.addGroup = function() {
	var newGroup = {
	    name:$scope.group
	}
	$http.post( 'group/new', newGroup ).
	success( function( data ){
		$scope.fetch();
		$scope.group = '';
	    }).
	error( function( data ){
	    });

    };

    $scope.$watch('groupSelected', function() {
	    //alert("newValue:");
		});
}
groupCtrl.$inject = ["$scope", "$http"];
