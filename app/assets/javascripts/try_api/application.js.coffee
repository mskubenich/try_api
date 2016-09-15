#= require try_api/params.directive
#= require try_api/param.directive
#= require try_api/paramsarray.directive
#= require try_api/image.directive
#= require try_api/url.directive

$ ->
  $('pre code').each (i, block) ->
    hljs.highlightBlock(block)


  $('.try-api-sidebar-menu').slimScroll
    height: '100%'

  Ladda.bind '.progress-demo button', callback: (instance) ->
    progress = 0
    interval = setInterval((->
      progress = Math.min(progress + Math.random() * 0.1, 1)
      instance.setProgress progress
      if progress == 1
        instance.stop()
        clearInterval interval
      return
    ), 200)
    return


TryApiApp = angular.module('TryApiApp', [
  'ui.bootstrap'
  'ngAnimate'
  'TryApi'
  'angular-ladda'
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


    $scope.getHtml = (html) ->
      return $sce.trustAsHtml(html)

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
    $scope.global_headers = {}
    $scope.params = []

    $http.get('/developers/projects.json').success (data) -> # TODO this should depends from app routes
      $scope.project = data.project
      $.each $scope.project.menu_items, () ->
        menu_item = this
        $.each menu_item.methods, ()->
          method = this
          method.pending = false
          method.response_handler = (data, status, headers, config) ->
            method.pending = false
            try # TODO catch different types of response
              data = JSON.stringify(data, null, 2)
            catch e

            method.response =
              data: data
              headers: JSON.stringify(config.headers, null, 2)
              status: status

          method.submit = ->
            method.pending = true
            headers = {'Content-Type': undefined}

            $.each method.headers, (i)->
              header = this
              headers[header.name] = header.value

            path = $scope.project.host + ':' + $scope.project.port + '/' + method.submit_path

            switch method.method.toLowerCase()
              when 'post'
                fd = new FormData
                fd.append 'a', 'a' # TODO sending empty array causes EOFError

                $.each method.parameters, (i) ->
                  if this.value
                    $scope.addParameterToForm fd, this

                $http.post path, fd,
                  transformRequest: angular.identity
                  headers: headers
                .success method.response_handler
                .error method.response_handler
              when 'delete'
                $http.delete path,
                  transformRequest: angular.identity
                  headers: headers
                .success method.response_handler
                .error method.response_handler
              when 'get'
                fd = ''

                $.each method.parameters, (i) ->
                  parameter = this
                  if this.value
                    fd = fd + parameter.name + '=' + (parameter.value || '') + '&'

                $http.get path + '?' + fd,
                  transformRequest: angular.identity
                  headers: headers
                .success method.response_handler
                .error method.response_handler
              when 'put'
                fd = new FormData
                fd.append 'a', 'a' # TODO sending empty array causes EOFError

                $.each method.parameters, (i) ->
                  if this.value
                    $scope.addParameterToForm fd, this

                $http.put path, fd,
                  transformRequest: angular.identity
                  headers: headers
                .success method.response_handler
                .error method.response_handler

    $scope.addParameterToForm = (form, parameter) -> # TODO implement multidimentional parameters
      if parameter.type == 'array'
        form.append 'a', 'a' # TODO sending empty array causes EOFError
        $.each parameter.values, ->
          value = this
          $.each value, ->
            subparameter = this
            switch subparameter.type
              when 'boolean'
                form.append parameter.name + '[]' + subparameter.name, subparameter.value || false
              else
                form.append parameter.name + '[]' + subparameter.name, subparameter.value || ''
      else
        form.append parameter.name, parameter.value || ''
]
