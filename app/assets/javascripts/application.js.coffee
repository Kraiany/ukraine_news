#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require ukraine_news

# for more details see: http://emberjs.com/guides/application/
window.UkraineNews = Ember.Application.create
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
  LOG_ACTIVE_GENERATION: true
  LOG_RESOLVER: true
  rootElement: "#app"
