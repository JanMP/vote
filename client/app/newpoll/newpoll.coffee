'use strict'

angular.module 'voteApp'
.config ($routeProvider) ->
  $routeProvider.when '/newpoll',
    templateUrl: 'app/newpoll/newpoll.html'
    controller: 'NewpollCtrl'
