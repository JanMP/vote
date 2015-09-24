'use strict'

angular.module 'voteApp'
.controller 'MainCtrl', ($scope, $http) ->
  
  $scope.showListing = true
  $scope.showEdit = true
  
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
    $scope.showListing = not $scope.showListing
    console.log 'toggleShowAll'

  $scope.polls = []
 
  $scope.switchToEditor = ->
    $scope.showEdit = true
    $scope.showListing = false

  $scope.switchToListing = ->
    $scope.showEdit = false
    $scope.showListing = true

  $scope.getAllPolls = ->
    $http.get('/api/pollss').success (polls) ->
      console.log 'accessing polls'
      $scope.polls = polls

  $scope.getAllPolls()

  $scope.addPoll = ->
    console.log 'adding new poll'
    $http.post '/api/pollss/', $scope.poll
    .then (data) ->
      $scope.polls.push data.data
      console.log data.data
    , (error) ->
      console.log "Error : #{error}"


  $scope.updatePoll = ->
    console.log 'updating poll'
    $http.put '/api/pollss/' + $scope.poll._id, $scope.poll
    .then (data) ->
      index = _($scope.polls).findIndex((elem) -> elem._id == data.data._id)
      $scope.polls[index] = data.data
    , (error) ->
      console.log (error)

  $scope.editPoll = (poll) ->
    console.log "editing poll #{poll._id}"
    $scope.poll =  _.cloneDeep poll
    $scope.switchToEditor()

  $scope.addAnswer = (index) ->
    $scope.poll.answers.splice index+1, 0,
      text : ''
      amount : 0

  $scope.submit = ->
    if not $scope.poll._id then $scope.addPoll() else $scope.updatePoll()
    $scope.switchToListing()


  $scope.deleteAnswer = (index) ->
    $scope.poll.answers.splice index, 1

  $scope.deletePoll = (poll) ->
    $http.delete '/api/pollss/' + poll._id
    .then (data) ->
      console.log "deleted poll #{poll._id}"
      index = _($scope.polls).findIndex((elem) -> elem._id == poll._id)
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