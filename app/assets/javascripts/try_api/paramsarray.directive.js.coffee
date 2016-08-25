angular.module 'paramsarray', []
angular.module('paramsarray').directive 'paramsarray', [
  '$filter'
  ($filter) ->

    link = (scope, element, attrs, ctrl) ->

      scope.parameter.values = []

      scope.addItem = ()->
        scope.parameter.values.push jQuery.extend(true, {}, scope.parameter.parameters)

    return {
      link: link
      restrict: 'A'
      require: 'ngModel'
      scope:
        parameter: '=ngModel'
      template: '' +
        '<div ng-repeat="value in parameter.values track by $index" style="border: 1px solid lightgray; margin: 1px 1px 1px 10px">' +
        '  <div params ng-model="value"></div>' +
        '</div>' +
        '<a class="btn btn-success btn-xs" ng-click="addItem()">+</a>'
    }
]