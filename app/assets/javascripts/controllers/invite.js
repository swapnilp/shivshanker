function InviteCtrl($scope,$http) {
 $scope.menual_submit = function(){

	var invitesArray = new Array();
	invitesArray.push({
	 name:$scope.user.name,
	 email:$scope.user.email,
	});
	var menualInvite = {
	invites: invitesArray
	}
	console.log(menualInvite);
	$http.post( 'invites/menual', menualInvite ).
		success( function( data ){
			//change the view
			alert("Invitation has been sent.");	
		}).
		error( function( data ){
			alert("Fial to send invitation.");
		});

 };//end of menual_submit  

	$http.get('current_user').
		success( function( data ){
			//change the view
			$scope.current_user = data;	
		}).
		error( function( data ){
			//alert("Fial to send invitation.");
			
		});

	
}
InviteCtrl.$inject = ["$scope","$http"];
