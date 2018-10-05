var app = angular.module('HelloApp', []);
app.controller('HelloController', function($scope) {
  $scope.greeting = { 
    text: 'Hello',
    name: 'World'
  };
});
