'use strict'

angular.module 'voteApp'
.directive 'pollthump', ->
  templateUrl: 'app/pollthump/pollthump.html'
  restrict: 'EA'
  link: (scope, element, attrs) ->
