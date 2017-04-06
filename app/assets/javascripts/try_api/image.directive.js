'use strict';

angular.module('TryApi').directive('image', ['$filter', function($filter) {

    function link(scope, element, attributes, ctrl) {

        var droppable_area = element.find('.droppable-area');
        var file_select = element.find('.file-select');

        scope.image = {};

        scope.removeImage = function(e){
            e.stopPropagation();
            e.preventDefault();
            scope.image.blob_url = null;
            return false;
        };

        var addImage = function(image){
            if(image.type.indexOf("image") > -1) {
                scope.$apply(function(){
                    scope.model = image;
                    scope.image = { blob_url: (window.URL || window.webkitURL).createObjectURL(image), filename: image.name };
                });
            }else{

            }
        };

        if (window.File && window.FileList && window.FileReader) {

            file_select[0].addEventListener("change", function(e){
                FileDragHover(e);
                var files = e.target.files || e.dataTransfer.files;
                if(files.length > 0) {
                    addImage(files[0]);
                }
            }, false);

            var xhr = new XMLHttpRequest();
            if (xhr.upload) {

                var FileDragHover = function(e) {
                    e.stopPropagation();
                    e.preventDefault();
                    if(e.type == 'dragover') {
                        droppable_area.addClass('file-hover')
                    }else{
                        droppable_area.removeClass('file-hover')
                    }
                };

                var FileSelectHandler = function(e) {
                    FileDragHover(e);

                    var files = e.target.files || e.dataTransfer.files;

                    if(files.length > 0) {
                        addImage(files[0]);
                    }
                };

                droppable_area[0].addEventListener("dragover", FileDragHover, false);
                droppable_area[0].addEventListener("dragleave", FileDragHover, false);
                droppable_area[0].addEventListener("drop", FileSelectHandler, false);
            }
        }
    }

    return {
        link: link,
        restrict: 'A',
        require: 'ngModel',
        scope: {
            model: '=ngModel'
        },
        template: "<div class='droppable-area'>" +
        "<ul class='images-list' >" +
        '<li class="plus" style="background-image: url(\'{{ image.blob_url || image.url }}\')">' +
        "<label>" +
        '<i class="fa fa-plus" ng-hide="image.blob_url"/>' +
        '<input type="file" class="file-select" />' +
        "</label>" +
        "</li>" +
        "<ul>" +
        "</div>"
    };
}]);