// From https://github.com/quanghoc/angular-bootstrap-scrollspy

'use strict';

angular.module('tryApiScrollSpy.directives', [])

    .directive("scrollTo", ["$window", function($window){
        return {
            restrict : "AC",
            compile : function(){

                function scrollInto(elementId) {
                    if(!elementId) $window.scrollTo(0, 0);
                    //check if an element can be found with id attribute
                    var el = document.getElementById(elementId);
                    if(el) el.scrollIntoView();
                }

                return function(scope, element, attr) {
                    element.bind("click", function(event){
                        scrollInto(attr.scrollTo);
                    });
                };
            }
        };
    }])

    .directive('scrollSpy', ['$window', '$timeout', '$rootScope', function($window, $timeout, $rootScope) {
        var targets,
            spies = [];

        var refresh = function(attrs) {
            var slice = Array.prototype.slice;

            $timeout(function() {
                targets = $(attrs.target).find('.second-level-menu-items li');
                slice.call(targets).forEach(function(el) {
                    var spy = $(el.querySelector('a').getAttribute('href'));

                    if (spy.length > 0) {
                        spies.push(spy);
                    }
                });
            }, 1000);
        };

        var activate = function(scope, $element, attrs) {
            $(attrs.target + ' .active').removeClass('active');
            if($element){
                $element.addClass('active');
            }
        };

        var process = function(scope, element, attrs) {
            var windowHeight = $window.innerHeight,
                windowTop = $window.scrollY,
                $activeTarget;

            spies.map(function(item, index) {
                var pos = item.offset().top - windowTop;

                if (pos < windowHeight) {
                    $activeTarget = targets.eq(index);
                }
            });

            // console.log($activeTarget);
            activate(scope, $activeTarget, attrs);
        };

        return {
            link: function(scope, element, attrs) {
                targets = [];
                spies = [];

                refresh(attrs);

                angular.element($window).bind("scroll", function() {
                    process(scope, element, attrs);
                    scope.$apply();
                });

                // When DOM changes, refresh with a broadcast like this $rootScope.$broadcast('scrollspy.refresh');
                $rootScope.$on('scrollspy.refresh', function() {
                    refresh(attrs);
                });

            }
        }
    }]);