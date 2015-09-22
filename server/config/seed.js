/**
 * Populate DB with sample data on server start
 * to disable, edit config/environment/index.js, and set `seedDB: false`
 */

'use strict';

//var Thing = require('../api/thing/thing.model');
var Polls = require('../api/polls/polls.model');
var User = require('../api/user/user.model');

Polls.find({}).remove(function(){
  Polls.create(
    {
        title: "Colors",
        question: "What is your favorite color?",
        answers: [
          {
            text: "Red",
            amount: 10
          }, {
            text: "Blue",
            amount: 3
          }, {
            text: "Yellow",
            amount: 4
          }
        ]
      }, {
        title: "Eats",
        question: "What is your preferred cuisine?",
        answers: [
          {
            text: "French cuisine is really, really tres delicieuse.",
            amount: 3
          }, {
            text: "Hamburger yummi!",
            amount: 48
          }, {
            text: "Italian food ist not bad, unless you want to cut down on carbs, off course.",
            amount: 20
          }, {
            text: "Chinese, off course. One billion people can't be all wrong.",
            amount: 359
          }
        ]
      }, {
        title: "Pets",
        question: "What species do you like to have around?",
        answers: [
          {
            text: "Cats",
            amount: 5243
          }, {
            text: "not Cats",
            amount: 3
          }
        ]
      }
  )
});

/*
Thing.find({}).remove(function() {
  Thing.create({
    name : 'Development Tools',
    info : 'Integration with popular tools such as Bower, Grunt, Karma, Mocha, JSHint, Node Inspector, Livereload, Protractor, Jade, Stylus, Sass, CoffeeScript, and Less.'
  }, {
    name : 'Server and Client integration',
    info : 'Built with a powerful and fun stack: MongoDB, Express, AngularJS, and Node.'
  }, {
    name : 'Smart Build System',
    info : 'Build system ignores `spec` files, allowing you to keep tests alongside code. Automatic injection of scripts and styles into your index.html'
  },  {
    name : 'Modular Structure',
    info : 'Best practice client and server structures allow for more code reusability and maximum scalability'
  },  {
    name : 'Optimized Build',
    info : 'Build process packs up your templates as a single JavaScript payload, minifies your scripts/css/images, and rewrites asset names for caching.'
  },{
    name : 'Deployment Ready',
    info : 'Easily deploy your app to Heroku or Openshift with the heroku and openshift subgenerators'
  });
});
*/
User.find({}).remove(function() {
  User.create({
    provider: 'local',
    name: 'Test User',
    email: 'test@test.com',
    password: 'test'
  }, {
    provider: 'local',
    role: 'admin',
    name: 'Admin',
    email: 'admin@admin.com',
    password: 'admin'
  }, function() {
      console.log('finished populating users');
    }
  );
});