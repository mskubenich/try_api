'use strict';

angular.module('TryApi').directive('curl', ['$filter', function($filter) {

    function link(scope, element, attributes, ctrl) {

        scope.curlString = '';

        scope.$watch(function(){
            return JSON.stringify(scope.model);
        }, function(){
            let method = scope.model.method.toString().toUpperCase();
            let headers = [];
            let formData = scope.isFormData(scope.model.parameters);

            if(formData) {

            }else{
                headers.push(" -H \"Content-Type: application/json\"");
            }

            if(scope.model.headers){
                scope.model.headers.forEach(function(header){
                    headers.push(' -H "' + header.name + ': ' + (header.value || '') + '"')
                })
            }

            let params = '';
            let urlParams = '';

            if(scope.model.parameters && scope.model.parameters.length > 0) {
                if (scope.model.method == 'get') {
                    urlParams += scope.toUrlParameters(scope.model.parameters);
                }else if (formData) {
                    params += ' -c -include ' + scope.toFormDataKeys(scope.model.parameters);
                } else {
                    params += ' -d "' + JSON.stringify(scope.toJsonParameters(scope.model.parameters)).replace(/"/g, '\\"').replace(/,/g, ', ') + '"';
                }
            }

            scope.curlString = 'curl -X ' + method + ' ' + headers.join('') + params + ' ' + scope.model.endpoint + '/' + scope.model.submit_path + urlParams;

        }, true)

        scope.toUrlParameters = function(parameters,prefix,result){
            if(!result)
                result = [];

            if(parameters && parameters.length > 0){
                parameters.forEach(function(parameter){

                    let name = '';

                    if(prefix) {
                        name = prefix + '[' + parameter.name + ']';
                    }else{
                        name = parameter.name;
                    }

                    if(parameter.type == 'array'){
                        if(parameter.values && parameter.values.length > 0){
                            let i = 0;
                            parameter.values.forEach(function(value){
                                let temp_parameters = [];
                                for(let k in value){
                                    temp_parameters.push(value[k]);
                                }
                                scope.toUrlParameters(temp_parameters, name + '[]', result);
                                i++;
                            })
                        }
                    }else{
                        let value = '';

                        if(parameter.type == 'image'){

                        }else{
                            value = parameter.value || '';
                            result.push(name + '=' + value);
                        }
                    }
                });
            }
            return '?' + result.join('&');
        }

        scope.toFormDataKeys = function(parameters, prefix){
            let result = '';

            if(parameters && parameters.length > 0){
                parameters.forEach(function(parameter){

                    let name = '';

                    if(prefix) {
                        name = prefix + '[' + parameter.name + ']';
                    }else{
                        name = parameter.name;
                    }

                    if(parameter.type == 'array'){
                        if(parameter.values && parameter.values.length > 0){
                            let i = 0;
                            parameter.values.forEach(function(value){
                                let temp_parameters = [];
                                for(let k in value){
                                    temp_parameters.push(value[k]);
                                }
                                result += scope.toFormDataKeys(temp_parameters, name + '[]');
                                i++;
                            })
                        }
                    }else{
                        let value = '';

                        if(parameter.type == 'image'){
                            value = parameter.value ? '@' + parameter.value.name : '';
                        }else{
                            value = parameter.value || '';
                        }

                        result += ' -F "' + name + '=' + value + '"';
                    }
                });
            }
            return result;
        }

        scope.toJsonParameters = function(parameters){
            let result = {};

            if(parameters && parameters.length > 0){
                parameters.forEach(function(parameter){
                    if(parameter.type == 'array'){
                        if(parameter.values && parameter.values.length > 0){
                            result[parameter.name] = [];
                            parameter.values.forEach(function(value){
                                let temp_parameters = [];
                                for(let k in value){
                                    temp_parameters.push(value[k]);
                                }
                                result[parameter.name].push(scope.toJsonParameters(temp_parameters));
                            })
                        }
                    }else{
                        result[parameter.name] = parameter.value;
                    }
                });
            }
            return result;
        }

        scope.isFormData = function(parameters){
            let result = false;

            if(parameters && parameters.length > 0){
                parameters.forEach(function(parameter){
                    if(parameter.type == 'array'){
                        if(parameter.values && parameter.values.length > 0){
                            parameter.values.forEach(function(value){
                                let temp_parameters = [];
                                for(let k in value){
                                    temp_parameters.push(value[k]);
                                }
                                result = scope.toJsonParameters(temp_parameters);
                            })
                        }
                    }else if(parameter.type == 'image'){
                        result = true;
                    }
                });
            }
            return result;
        }
    }

    return {
        link: link,
        restrict: 'A',
        require: 'ngModel',
        scope: {
            model: '=ngModel'
        },
        template: "{{ curlString }}"
    };
}]);