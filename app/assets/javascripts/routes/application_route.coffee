UkraineNews.ApplicationRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo 'articles'
