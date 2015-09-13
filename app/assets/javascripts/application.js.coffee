#= require jquery
#= require jquery.timeago
#= require jquery.timeago.uk
#= require bootstrap.min
#= require_tree ./summarize
#= require_self

jQuery.timeago.settings.allowFuture = true
$ ->
  $('.timeago').timeago()
