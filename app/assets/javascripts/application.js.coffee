#= require jquery
#= require jquery_ujs
#= require jquery.timeago
#= require jquery.hotkeys
#= require 'date_to_iso_string'
#= require bootstrap.min
#= require handlebars
#= require hammer.min
#= require ember
#= require ember-data
#= require ember-hammer
#= require_self
#= require ukraine_news

# for more details see: http://emberjs.com/guides/application/
window.UkraineNews = Ember.Application.create
  rootElement: "#app"
  ready: ->
    $('.before_render_content').hide()

jQuery.timeago.settings.allowFuture = true

UkraineNews.Router.reopen
  location: 'history'
  notifyGoogleAnalytics: (->
    ga 'send', 'pageview',
      'page': @get('url'),
      'title': @get('url')
  ).on('didTransition')
