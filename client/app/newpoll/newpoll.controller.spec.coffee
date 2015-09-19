'use strict'

describe 'Controller: NewpollCtrl', ->

  # load the controller's module
  beforeEach module 'voteApp'
  NewpollCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    NewpollCtrl = $controller 'NewpollCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
