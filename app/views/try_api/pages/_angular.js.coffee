'use strict'
TryApiApp = angular.module('TryApiApp', [
  'ui.bootstrap'
#    'formInput.images'
#    'formInput.image'
#    'formInput.file'
    'hljs'
])
TryApiApp.config [
  '$httpProvider'
  'hljsServiceProvider'
  ($httpProvider, hljsServiceProvider) ->
    hljsServiceProvider.setOptions
      tabReplace: '  '
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
  '$http'
  ($scope, $timeout, $sce, $http) ->

    $scope.getStatusCodeClass = (code) ->
      switch true
        when code >= 200 && code < 300
          return 'text-success'
        when code >= 300 && code < 400
          return 'text-warning'
        when code >= 400 && code < 500
          return 'text-danger'
        when code >= 500
          return 'text-danger'
        else
          return 'text-info'

    $scope.headers = []
    $scope.params = []

    <% index = 0 %>
    <% @project.categories.each do |category| %>
    <% category.menu_items.each do |menu_item| %>
    <% index += 1 %>
    <% menu_item.second_level_menu_items.each do |method| %>
    <% index += 1 %>

    $scope.params[<%= index %>] = {}

    $scope.responseHandler<%= index %> = (data, status, headers, config) ->
      $scope.response<%= index %> =
        data: JSON.stringify(data, null, 2)
        headers: JSON.stringify(config.headers, null, 2)
        status: status
      return

    $scope.submitForm<%= index %> = ->
      fd = new FormData
      <% method.parameters.each_with_index do |parameter, i| %>
      fd.append '<%= parameter.name %>', $scope.params[<%= index %>][<%= i %>]
      <% end %>

      $http.<%= method.method.downcase %> '<%= method.full_path %>', fd,
        transformRequest: angular.identity
        headers:
          'Content-Type': undefined
          <% method.headers.each_with_index do |header, i| %>
          '<%= header.name %>': $scope.headers[<%= index %>][<%= i %>]
          <% end %>

      .success $scope.responseHandler<%= index %>
      .error $scope.responseHandler<%= index %>

      console.log $scope.headers[<%= index %>]

    <% end %>
    <% end %>
    <% end %>
]