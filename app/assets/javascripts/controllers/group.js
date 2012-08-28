function groupCtrl($scope) {
    $scope.groups = [];
    
    $scope.addGroup = function() {
	$scope.groups.push($scope.group);
    };
}
groupCtrl.$inject = ["$scope"];
