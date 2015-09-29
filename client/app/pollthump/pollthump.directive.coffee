'use strict'

angular.module 'voteApp'
.directive 'pollthump', ->
  templateUrl: 'app/pollthump/pollthump.html'
  restrict: 'EA'
  link: (scope, element, attrs) ->  
    
    colorPalette = palette 'rainbow', scope.poll.answers.length, 1, 0.4, 0.8
    highlightPalette = palette 'rainbow', scope.poll.answers.length, 1, 0.6, 0.7
    
    data = _.map scope.poll.answers, (answer, n) ->
      value : answer.amount
      label : if answer.text.length < 11 then answer.text else scope.letter(n)
      color : '#'+colorPalette[n]
      highlight : '#'+highlightPalette[n]
    
    options =
      responsive : true

    ctx = element.find('.chart')[0].getContext('2d')
    console.log 'still fine'
    myChart = new Chart(ctx).Pie(data, options)
