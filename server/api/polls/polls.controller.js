'use strict';

var _ = require('lodash');
var Polls = require('./polls.model');

// Get list of pollss
exports.index = function(req, res) {
  Polls.find(function (err, pollss) {
    if(err) { return handleError(res, err); }
    return res.status(200).json(pollss);
  });
};

// Get a single polls
exports.show = function(req, res) {
  Polls.findById(req.params.id, function (err, polls) {
    if(err) { return handleError(res, err); }
    if(!polls) { return res.status(404).send('Not Found'); }
    return res.json(polls);
  });
};

// Creates a new polls in the DB.
exports.create = function(req, res) {
  Polls.create(req.body, function(err, polls) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(polls);
  });
};

// Updates an existing polls in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Polls.findById(req.params.id, function (err, polls) {
    if (err) { return handleError(res, err); }
    if(!polls) { return res.status(404).send('Not Found'); }
    var updated = _.extend(polls, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(polls);
    });
  });
};

// Deletes a polls from the DB.
exports.destroy = function(req, res) {
  Polls.findById(req.params.id, function (err, polls) {
    if(err) { return handleError(res, err); }
    if(!polls) { return res.status(404).send('Not Found'); }
    polls.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}