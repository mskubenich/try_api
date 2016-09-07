angular.module('TryApi').directive 'param', [
  '$filter',
  '$sce'
  ($filter, $sce) ->

    link = (scope, element, attrs, ctrl) ->
      scope.unique_id = Math.random()

      scope.getHtml = (html) ->
        return $sce.trustAsHtml(html)

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
        '    <textarea ng-switch-when="text" class="form-control" ng-model="parameter.value" placeholder=\'{{ parameter.required ? "required" : "optional"}}\' style="max-width: 100%" />' +
        '    <input ng-switch-when="integer" type="number" class="form-control" ng-model="parameter.value" placeholder=\'{{ parameter.required ? "required" : "optional"}}\'>' +
        '    <div ng-switch-when="boolean" class="onoffswitch">' +
        '      <input class="onoffswitch-checkbox" ng-model="parameter.value" type="checkbox" id="{{ unique_id }}-on-off-switch">' +
        '      <label class="onoffswitch-label" for="{{ unique_id }}-on-off-switch"></label>' +
        '      <span class="onoffswitch-inner"></span>' +
        '      <span class="onoffswitch-switch"></span>' +
        '    </div>' +
        '    <div ng-switch-when="image" image=true" ng-model="parameter.value"></div>' +
        '    <input ng-switch-default type="text" class="form-control" ng-model="parameter.value" placeholder=\'{{ parameter.required ? "required" : "optional"}}\'>' +
        '  </div>' +
        '  <div class="text-muted small" ng-bind-html="getHtml(parameter.description)"></div>' +
        '</div>' +
        '<div class="col-md-12" ng-if=\'parameter.type == "array"\'>' +
        '  <div class="row">' +
        '    <div class="col-md-4 text-right">' +
        '      <b>{{ parameter.name }}</b>' +
        '      <span class="text-muted label label-warning">{{ parameter.type }}</span>' +
        '    </div>' +
        '    <div class="col-md-8">' +
        '      <div class="text-muted small" ng-bind-html="getHtml(parameter.description)"></div>' +
        '    </div>' +
        '  </div>' +
        '  <div paramsarray ng-model="parameter"></div>' +
        '</div>'
    }
]