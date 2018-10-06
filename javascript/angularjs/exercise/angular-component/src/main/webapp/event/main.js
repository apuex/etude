require(['angular'], function(angular) {
  var app = angular.module('eventApp', []);
  app.controller("eventController", function ($scope, $window) {
    $scope.DisplayMessage = function (value) {
      $scope.newPassword = value;
    };
  });
});