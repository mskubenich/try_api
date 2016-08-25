angular.module 'param', []
angular.module('param').directive 'param', [
  '$filter'
  ($filter) ->

    link = (scope, element, attrs, ctrl) ->

    return {
      link: link
      restrict: 'A'
      require: 'ngModel'
      scope:
        parameter: '=ngModel'
      template: '' +
        '<div class="col-md-4 text-right" ng-if=\'parameter.type != "array"\'>' +
        '  <b>{{ parameter.name }}</b>' +
        '  <span class="text-muted label label-warning">{{ parameter.type }}</span>' +
        '</div>' +
        '<div class="col-md-8" ng-if=\'parameter.type != "array"\'>' +
        '  <div ng-switch="parameter.type">' +
        '    <input ng-switch-when="string" type="text" class="form-control" ng-model="parameter.value" placeholder=\'{{ parameter.required ? "required" : "optional"}}\'>' +
        '    <input ng-switch-when="integer" type="number" class="form-control" ng-model="parameter.value" placeholder=\'{{ parameter.required ? "required" : "optional"}}\'>' +
        '    <div ng-switch-when="boolean" class="onoffswitch">' +
        '      <input class="onoffswitch-checkbox" ng-model="parameter.value" type="checkbox" id="{{ parameter.id }}-on-off-switch">' +
        '      <label class="onoffswitch-label" for="{{ parameter.id }}-on-off-switch"></label>' +
        '      <span class="onoffswitch-inner"></span>' +
        '      <span class="onoffswitch-switch"></span>' +
        '    </div>' +
        '    <input ng-switch-default type="text" class="form-control" ng-model="parameter.value" placeholder=\'{{ parameter.required ? "required" : "optional"}}\'>' +
        '  </div>' +
        '  <div class="text-muted small">{{ parameter.description }}</div>' +
        '</div>' +
        '<div class="col-md-12" ng-if=\'parameter.type == "array"\'>' +
        '  <div class="row">' +
        '    <div class="col-md-4 text-right">' +
        '      <b>{{ parameter.name }}</b>' +
        '      <span class="text-muted label label-warning">{{ parameter.type }}</span>' +
        '    </div>' +
        '    <div class="col-md-8">' +
        '      <div class="text-muted small">{{ parameter.description }}</div>' +
        '    </div>' +
        '  </div>' +
        '  <div paramsarray ng-model="parameter"></div>' +
        '</div>'
    }
]