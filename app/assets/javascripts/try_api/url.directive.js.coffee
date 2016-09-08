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
          if i.value == '' then '0' else i.value
        ).join('/')
      , true

      scope.inputStyle = (part) ->
        charWidth = 13.3;
        return  {
          "width": ((part.value).length + 1) * charWidth + "px",
          "min-width": ((part.placeholder).length) * charWidth + "px"
        }

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
        '<input ng-if="isParameter(part.placeholder)" ng-model="part.value" class="url-input" ng-style="inputStyle(part)" placeholder="{{ part.placeholder }}" scope="max-width: 90%; font-family:monospace;"/>' +
        '</span>'
    }
]
