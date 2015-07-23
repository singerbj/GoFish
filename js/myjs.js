var app = angular.module('GoFish', []);

app.controller('Controller', ["$scope", "$http", function($scope, $http) {
    var self = this;
    $http.get('/currentUser').success(function(data){
        self.currentUser = data[0];
    }).error(function(err){
        console.log(err);
    });

    self.updateCurrentUser = function(user){
        $http.put('/users/' + user.id, user).success(function(data){
            console.log('user update success');
        }).error(function(err){
            console.error(err);
        });
    };
}]);

app.filter('cap', function() {
    return function(input, scope) {
        if (input){
            input = input.toLowerCase();
            return input.substring(0, 1).toUpperCase() + input.substring(1);
        }
    };
});
