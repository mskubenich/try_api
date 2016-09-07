angular.module('TryApi').directive 'url', [
  '$filter',
  '$sce'
  ($filter, $sce) ->

    link = (scope, element, attrs, ctrl) ->

      scope.isParameter = (value) ->
        if value
          return value.indexOf(':') != -1
        else
          return false

      scope.parts = scope.pattern.split('/').filter(Boolean).map (i)->
        value = if scope.isParameter(i) then '' else i
        {
          value: value,
          placeholder: i
        }

      scope.$watch 'parts', ->
        scope.url = scope.parts.map((i)->
          i.value
        ).join('/')
      , true

    return {
      link: link
      restrict: 'A'
      require: 'ngModel'
      scope:
        url: '=ngModel'
        pattern: '=pattern'
      template: '<span ng-repeat="part in parts track by $index">' +
        '/' +
        '<span ng-if="!isParameter(part.placeholder)">{{ part.value }}</span>' +
        '<input ng-if="isParameter(part.placeholder)" ng-model="part.value" placeholder="{{ part.placeholder }}"/>' +
        '</span>'
    }
]