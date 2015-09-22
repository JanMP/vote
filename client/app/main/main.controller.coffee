'use strict'

angular.module 'voteApp'
.controller 'MainCtrl', ($scope, $http) ->
  $scope.showAll = false
  $scope.poll =
    title : ''
    question : ''
    answers : [
      text : ''
      amount : 0
    ,
      text : ''
      amount : 0
    ]

  

  $scope.toggleShowAll = ->
    $scope.showAll = not $scope.showAll
    console.log 'toggleShowAll'

  $scope.polls = []
 

  $scope.getAllPolls = ->
    $http.get('/api/pollss').success (polls) ->
      console.log 'accessing polls'
      $scope.polls = polls

  $scope.getAllPolls()

  $scope.addPoll = ->
    $http.post '/api/pollss', $scope.poll

  $scope.deletePoll = (poll) ->
    $http.delete '/api/pollss/' + poll._id
    .then (data) ->
      console.log "deleted poll #{poll._id}"
      index = _($scope.polls).find((pollInArr) -> pollInArr._id == poll._id)
      console.log "Index of object to delete: #{index}"
      $scope.polls.splice index, 1
    , (error) ->
      console.log "deletePoll Error: #{error}"

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