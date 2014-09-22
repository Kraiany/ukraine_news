UkraineNews.ArticleRoute = Ember.Route.extend
  activate: ->
    @_super()
    @controllerFor('article').trigger('didTransition')
