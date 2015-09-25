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

  $scope.polls = []
  $scope.dummy = {}
  $scope.dummy.selected = 0

  $scope.letter = (n) ->
    if n <= 25 then String.fromCharCode(n + 65) else n+1

  $scope.toggleShowAll = ->
    $scope.showListing = not $scope.showListing
    console.log 'toggleShowAll'

  $scope.switchToEditor = ->
    $scope.showEdit = true
    $scope.showListing = false
    $scope.showBallot = false

  $scope.switchToListing = ->
    $scope.showEdit = false
    $scope.showListing = true
    $scope.showBallot = false

  $scope.switchToListing()

  $scope.switchToBallot = ->
    $scope.showEdit = false
    $scope.showListing = false
    $scope.showBallot = true

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

  $scope.vote = (poll) ->
    console.log "voting on poll #{poll._id}"
    $scope.poll =  _.cloneDeep poll
    $scope.dummy.selected = -1
    $scope.switchToBallot()

  $scope.editPoll = (poll) ->
    console.log "editing poll #{poll._id}"
    $scope.poll =  _.cloneDeep poll
    $scope.dummy.selected = -1
    $scope.switchToEditor()

  $scope.addAnswer = (index) ->
    $scope.poll.answers.splice index+1, 0,
      text : ''
      amount : 0

  $scope.submit = ->
    if $scope.dummy.selected >-1
      $scope.poll.answers[$scope.dummy.selected].amount += 1
      
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