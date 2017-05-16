angular.module('TryApi', []);

angular.module('TryApi').directive('params', [
  function() {
    var link;
    link = function(scope, element, attrs, ctrl) {

    };

    return {
      link: link,
      restrict: 'A',
      require: 'ngModel',
      scope: {
        parameters: '=ngModel'
      },
      template: '' +
        '<div class="row parameter" ng-repeat="parameter in parameters">' +
        '  <div param ng-model="parameter">' +
        '</div>'
    };
  }
]);