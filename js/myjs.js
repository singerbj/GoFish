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

    self.getAFish = function(){
        $http.get('/random_user').success(function(data){
            self.currentFish = data;
        }).error(function(err){
            console.error(err);
        });
    };

    self.reelIn = function(user){
        $http.post('/feelings/'+ user.id + '/like').success(function(data){
            console.log('Like success');
            self.getAFish();
            self.getMyMatches();
        }).error(function(err){
            console.error(err);
        });
    };

    self.throwBack = function(user){
        $http.post('/feelings/'+ user.id + '/dislike').success(function(data){
            console.log('Dislike success');
            self.getAFish();
            self.getMyMatches();
        }).error(function(err){
            console.error(err);
        });
    };

    self.getMyMatches = function(user){
        $http.get('/my_matches').success(function(data){
            angular.forEach(data, function(d){
                d.matched_user = JSON.parse(d.matched_user);
            });
            self.myMatches = data;

        }).error(function(err){
            console.error(err);
        });
    };

    self.getAFish();
    self.getMyMatches();
}]);

app.filter('cap', function() {
    return function(input, scope) {
        if (input){
            input = input.toLowerCase();
            return input.substring(0, 1).toUpperCase() + input.substring(1);
        }
    };
});
