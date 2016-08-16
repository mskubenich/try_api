#= require try_api/bower_components/jquery/dist/jquery.js
#= require try_api/bower_components/bootstrap/dist/js/bootstrap.min.js
#= require try_api/bower_components/jquery-slimscroll/jquery.slimscroll.min.js
#= require try_api/bower_components/highlightjs/highlight.pack.min.js
#= require try_api/bower_components/angular/angular.js
#= require try_api/bower_components/angular-bootstrap/ui-bootstrap-tpls.js
#= require try_api/bower_components/angular-highlightjs/src/angular-highlightjs.js

$ ->
  $('pre code').each (i, block) ->
    hljs.highlightBlock(block)


  $('.try-api-sidebar-menu').slimScroll
    height: '100%'



