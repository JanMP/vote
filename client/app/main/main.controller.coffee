'use strict'

angular.module 'voteApp'
.controller 'MainCtrl', ($scope, $http, Auth) ->
  
  $scope.showListing = true
  $scope.showEdit = true
  
  Poll = ->
    title : ''
    question : ''
    creator : ''
    answers : [
      text : ''
      amount : 0
    ,
      text : ''
      amount : 0
    ]
    haveVoted: []

  $scope.poll = Poll()

  $scope.polls = []
  $scope.dummy = {}
  $scope.dummy.selected = 0

  $scope.getCurrentUser = Auth.getCurrentUser
  $scope.isLoggedIn = Auth.isLoggedIn

  $scope.letter = (n) ->
    if n <= 25 then String.fromCharCode(n + 65) else n+1

  $scope.toggleShowAll = ->
    $scope.showListing = not $scope.showListing
    console.log 'toggleShowAll'

  $scope.hasVoted = (poll) ->
    _(poll.haveVoted).contains $scope.getCurrentUser()._id

  $scope.mayVote = (poll) ->
    if $scope.isLoggedIn() and not $scope.hasVoted poll then true

  $scope.mayEdit = (poll) ->
    $scope.isLoggedIn() and poll.creator is $scope.getCurrentUser()._id or $scope.getCurrentUser().role is 'admin'

  $scope.mayCreate = ->
    $scope.isLoggedIn()

  $scope.switchToEditor = ->
    if $scope.mayEdit($scope.poll) or $scope.mayCreate()
      console.log "creator: #{$scope.getCurrentUser()._id}"
      if $scope.poll.creator is '' then $scope.poll.creator = $scope.getCurrentUser()._id
      $scope.showEdit = true
      $scope.showListing = false
      $scope.showBallot = false

  $scope.switchToListing = ->
    $scope.showEdit = false
    $scope.showListing = true
    $scope.showBallot = false

  $scope.switchToListing()

  $scope.switchToBallot = ->
    if $scope.mayVote $scope.poll
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

  $scope.newPoll = ->
    console.log "creating new poll"
    $scope.editPoll new Poll()

  $scope.addAnswer = (index) ->
    $scope.poll.answers.splice index+1, 0,
      text : ''
      amount : 0

  $scope.submit = ->
    if $scope.dummy.selected >-1
      $scope.poll.answers[$scope.dummy.selected].amount += 1
      $scope.poll.haveVoted.push $scope.getCurrentUser()._id
      console.log $scope.poll
      
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