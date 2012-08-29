function accountInfoCtrl($scope, $http) {
    $scope.resetPassword = function() {
	var resetPassword = {
            password:$scope.password,
	    password_confirmation:$scope.password_confirmation
        }
        $http.post( 'reset_password',  resetPassword ).
        success( function( data ){
		$scope.password = '';
		$scope.password_confirmation = '';
		alert("changed");
            }).
        error( function( data ){
		alert("not changed");
            });
    };

}
accountInfoCtrl.$inject = ["$scope", "$http"];
