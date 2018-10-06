require(['angular'], function(angular) {
  var app = angular.module('watchApp', []);
  app.controller('watchController', function($scope) {
    $scope.message = "Hello World!";

    $scope.$watch('message', function (newValue, oldValue) {
        $scope.newMessage = newValue;
        $scope.oldMessage = oldValue;
    });
  });
});