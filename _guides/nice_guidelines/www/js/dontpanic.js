var app = angular.module('dontpanic', ['ngCordova']);

app.controller('GuidelineCtrl', function($scope, $window){
    $scope.title = "Nice Guidelines";
    
    $scope.guidelines = $window.guidelines.guidelines || [];
    $scope.categories = $window.guidelines.categories || [];
    console.log($scope.guidelines);

});
