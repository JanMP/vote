'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var answer = new Schema({
  text : String,
  amount : Number
});

var PollsSchema = new Schema({
  title: String,
  question: String,
  creator : String,
  answers: [answer],
  haveVoted : [String]
});

module.exports = mongoose.model('Polls', PollsSchema);