function groupCtrl($scope) {
    $scope.groups = [];
    
    $scope.addGroup = function() {
	$scope.groups.push($scope.group);
    };
    
    $scope.$watch('groupSelected', function() {
	    //alert("newValue:");
		});
}
groupCtrl.$inject = ["$scope"];
