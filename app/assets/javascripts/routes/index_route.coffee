UkraineNews.IndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo 'articles'
