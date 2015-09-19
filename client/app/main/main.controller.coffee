'use strict'

angular.module 'voteApp'
.controller 'MainCtrl', ($scope, $http) ->

  $scope.polls = [
    title : "Colors"
    description : "What's your favorite color?"
  ,
    title : "Eat this!"
    description : "What type of cuisine do you prefer?"
  ,
    title : "Intoxicating"
    description : "What's for favorite poison?"
  ]

###
  $scope.awesomeThings = []

  $http.get('/api/things').success (awesomeThings) ->
    $scope.awesomeThings = awesomeThings
    

  $scope.addThing = ->
    return if $scope.newThing is ''
    $http.post '/api/things',
      name: $scope.newThing

    $scope.newThing = ''

  $scope.deleteThing = (thing) ->
    $http.delete '/api/things/' + thing._id
###