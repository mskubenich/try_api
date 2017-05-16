angular.module('TryApi').directive('url', [
  '$filter', '$sce', function($filter, $sce) {
    var link;
    link = function(scope, element, attrs, ctrl) {
      scope.isParameter = function(value) {
        if (value) {
          return value.indexOf(':') !== -1;
        } else {
          return false;
        }
      };
      scope.parts = scope.pattern.split('/').filter(Boolean).map(function(i) {
        var value;
        value = scope.isParameter(i) ? '' : i;
        return {
          value: value,
          placeholder: i
        };
      });
      scope.$watch('parts', function() {
        return scope.url = scope.parts.map(function(i) {
          if (i.value === '') {
            return '0';
          } else {
            return i.value;
          }
        }).join('/');
      }, true);
      return scope.inputStyle = function(part) {
        var charWidth;
        charWidth = 11.5;
        return {
          "width": (part.value.length + 1) * charWidth + "px",
          "min-width": part.placeholder.length * charWidth + "px"
        };
      };
    };
    return {
      link: link,
      restrict: 'A',
      require: 'ngModel',
      scope: {
        url: '=ngModel',
        pattern: '=pattern'
      },
      template: '' +
        '<span ng-repeat="part in parts track by $index">' +
          '/' +
          '<span ng-if="!isParameter(part.placeholder)">{{ part.value }}</span>' +
          '<input ng-if="isParameter(part.placeholder)" ng-model="part.value" class="url-input" ng-style="inputStyle(part)" placeholder="{{ part.placeholder }}" scope="max-width: 90%; font-family:monospace;"/>' +
        '</span>'
    };
  }
]);