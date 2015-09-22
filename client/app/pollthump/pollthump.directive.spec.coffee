'use strict'

describe 'Directive: pollthump', ->

  # load the directive's module and view
  beforeEach module 'voteApp'
  beforeEach module 'app/pollthump/pollthump.html'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<pollthump></pollthump>'
    element = $compile(element) scope
    scope.$apply()
    expect(element.text()).toBe 'this is the pollthump directive'

