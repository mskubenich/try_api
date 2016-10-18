#= require try_api/params.directive
#= require try_api/param.directive
#= require try_api/paramsarray.directive
#= require try_api/image.directive
#= require try_api/url.directive
#= require try_api/scrollspy.directive

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
  'ngCookies'
  'TryApi'
  'angular-ladda'
  'hljs'
  'tryApiScrollSpy.directives'
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
  '$http',
  '$cookies'
  ($scope, $timeout, $sce, $http, $cookies) ->


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

    $scope.methodSubmit = (method) ->
      method.pending = true
      headers = {'Content-Type': undefined}

      $.each method.headers, (i)->
        header = this
        headers[header.name] = header.value

      path = method.submit_path

      switch method.method.toLowerCase()
        when 'post'
          fd = new FormData
          fd.append 'a', 'a' # TODO sending empty array causes EOFError

          $.each method.parameters, (i) ->
            $scope.addParameterToForm fd, this

          $http.post path, fd,
            transformRequest: angular.identity
            headers: headers
          .success method.response_handler
          .error method.response_handler
        when 'delete'
          url = ''

          $.each method.parameters, (i) ->
            url = $scope.addParameterToUrl(url, this)

          $http.delete path + '?' + url,
            transformRequest: angular.identity
            headers: headers
          .success method.response_handler
          .error method.response_handler
        when 'get'
          url = ''

          $.each method.parameters, (i) ->
            url = $scope.addParameterToUrl(url, this)

          $http.get path + '?' + url,
            transformRequest: angular.identity
            headers: headers
          .success method.response_handler
          .error method.response_handler
        when 'put'
          fd = new FormData
          fd.append 'a', 'a' # TODO sending empty array causes EOFError

          $.each method.parameters, (i) ->
            $scope.addParameterToForm fd, this

          $http.put path, fd,
            transformRequest: angular.identity
            headers: headers
          .success method.response_handler
          .error method.response_handler

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

          switch method.method.toLowerCase()
            when 'web_socket'
              method.submit = ->
                $.each method.cookies, (i) ->
                  $cookies.put(this.name, this.value)

                method.pending = true
                method.connected = false
                method.response = {data: []}

                if 'WebSocket' of window
                  method.ws = new WebSocket('ws://' + $scope.project.endpoint + '/' + method.submit_path)

                  method.ws.onopen = ->
                    $scope.$apply ->
                      method.pending = false
                      method.response.data.push('Connected')
                      method.ws.send(JSON.stringify({command: "subscribe", identifier: JSON.stringify(method.identifier)}))
                      method.response.data.push('Subscribed to ' + JSON.stringify(method.identifier))
                      method.connected = true

                  method.ws.onmessage = (evt) ->
                    $scope.$apply ->
                      if(JSON.parse(evt.data).type != 'ping')
                        method.response.data.push(evt.data)

                  method.ws.onclose = ->
                    $scope.$apply ->
                      method.pending = false
                      method.connected = false
                      method.response.data.push('Disconnected')

                else
                  method.response.data.push('WebSocket NOT supported by your Browser!')

              method.speak = ->
                method.ws.send JSON.stringify({
                  command: "message",
                  data: JSON.stringify({ message: method.message, action: 'speak'})
                  identifier: JSON.stringify(method.identifier)
                })
                method.message = ''
            else
              method.submit = ->
                $scope.methodSubmit(method)
    .error (data, status, headers, config) ->
      if status = 422
        alert data.error

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
        switch parameter.type
          when 'boolean'
            form.append parameter.name, parameter.value || false
          else
            if parameter.value
              form.append parameter.name, parameter.value || ''

    $scope.addParameterToUrl = (url, parameter) ->
      if parameter.type == 'array'
        $.each parameter.values, ->
          value = this
          $.each value, ->
            subparameter = this
            switch subparameter.type
              when 'boolean'
                url = url + parameter.name + '[]' + (subparameter.name || '') + '=' + (subparameter.value || false) + '&'
              else
                if subparameter.value
                  url = url + parameter.name + '[]' + (subparameter.name || '') + '=' + subparameter.value + '&'
      else
        switch parameter.type
          when 'boolean'
            url = url + parameter.name + '=' + (parameter.value || false) + '&'
          else
            if parameter.value
              url = url + parameter.name + '=' + parameter.value + '&'
      return url
]
