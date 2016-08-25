angular.module 'params', []
angular.module('params').directive 'params', [
  () ->

    link = (scope, element, attrs, ctrl) ->

    return {
      link: link
      restrict: 'A'
      require: 'ngModel'
      scope:
        parameters: '=ngModel'
      template: '' +
        '<div class="row parameter" ng-repeat="parameter in parameters">' +
        '  <div param ng-model="parameter">' +
        '</div>'
    }
]