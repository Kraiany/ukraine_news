UkraineNews.ArticlesRoute = Ember.Route.extend
  model: ->
    @store.findAll 'article'
