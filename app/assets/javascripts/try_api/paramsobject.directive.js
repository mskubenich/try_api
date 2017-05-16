angular.module('TryApi').directive('paramsobject', [
  '$filter', function($filter) {
    var link;
    link = function(scope, element, attrs, ctrl) {
      scope.parameter.values = jQuery.extend(true, {}, scope.parameter.parameters);
      if (scope.parameter.custom) {
        scope["new"] = {};
        scope.checkDuplicate = function() {
          var duplicate, parameters;
          duplicate = false;
          parameters = scope.parameter.parameters;
          $.each(parameters, function() {
            if (this.name === scope["new"].name) {
              duplicate = true;
              return false;
            }
          });
          return duplicate;
        };
        return scope.addItem = function() {
          var last;
          if (scope["new"].name && scope["new"].type && !scope.checkDuplicate()) {
            last = {
              name: scope["new"].name,
              type: scope["new"].type
            };
            if (last.type === 'object') {
              last.custom = true;
              last.parameters = [];
            }
            scope.parameter.parameters.push(last);
            return scope.parameter.values[scope.parameter.parameters.length - 1] = last;
          }
        };
      }
    };
    return {
      link: link,
      restrict: 'A',
      require: 'ngModel',
      scope: {
        parameter: '=ngModel'
      },
      template: '' +
        '<div style="border: 1px solid lightgray; margin: 1px 1px 1px 10px; padding: 0 10px 10px">' +
        '  <div params ng-model="parameter.values"></div>' +
        '</div>' +
        '<div class="col-md-12" style="margin-top: 10px" ng-if="parameter.custom == true">' +
        ' <div class="col-md-6">' +
        '   <input type="text" ng-model="new.name" placeholder="field name">' +
        ' </div>' +
        ' <div class="col-md-6">' +
        '   <input type="text" ng-model="new.type" placeholder="field type">' +
        ' </div>' +
        '</div>' +
        '<div class="try-api-array-item try-api-array-item-add" style="margin-top: 50px" ng-click="addItem()" ng-if="parameter.custom == true">' +
        '  <a>Add</a>' +
        '</div>'

    };
  }
]);