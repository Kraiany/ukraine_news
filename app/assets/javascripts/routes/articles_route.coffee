UkraineNews.ArticlesRoute = Ember.Route.extend
  queryParams:
    q:
      refreshModel: true
  model: (params) ->
    if params.q?
      @store.find 'article', {q: params.q}
    else
      @store.findAll 'article'
