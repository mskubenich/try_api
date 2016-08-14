do ->
  'use strict'
  TryApiApp = angular.module('TryApiApp', [
    'ui.bootstrap'
#    'formInput.images'
#    'formInput.image'
#    'formInput.file'
#    'hljs'
  ])
  TryApiApp.config [
    '$httpProvider'
    ($httpProvider) ->

  ]
  TryApiApp.run [
    '$http'
    '$rootScope'
    ($http, $rootScope) ->
  ]

  TryApiApp.controller 'HomeController', [
    '$scope'
    '$timeout'
    '$sce'
    ($scope, $timeout, $sce) ->

      $scope.headers = []
      $scope.params = []

      <% index = 0 %>
      <% @project.categories.each do |category| %>
      <% category.menu_items.each do |menu_item| %>
      <% index += 1 %>
      <% menu_item.second_level_menu_items.each do |method| %>
      <% index += 1 %>

      $scope.submitForm<%= index %> = ->
        console.log $scope.headers[<%= index %>]
        console.log $scope.params[<%= index %>]

      <% end %>
      <% end %>
      <% end %>
  ]