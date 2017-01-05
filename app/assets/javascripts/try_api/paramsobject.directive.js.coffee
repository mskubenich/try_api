angular.module('TryApi').directive 'paramsobject', [
  '$filter'
  ($filter) ->

    link = (scope, element, attrs, ctrl) ->

      scope.parameter.values = jQuery.extend(true, {}, scope.parameter.parameters)

    return {
      link: link
      restrict: 'A'
      require: 'ngModel'
      scope:
        parameter: '=ngModel'
      template: '' +
        '<div style="border: 1px solid lightgray; margin: 1px 1px 1px 10px">' +
        '  <div params ng-model="parameter.values"></div>' +
        '</div>'
    }
]
