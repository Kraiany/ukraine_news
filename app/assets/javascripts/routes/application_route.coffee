UkraineNews.ApplicationRoute = Ember.Route.extend
  actions:
    search: (query) ->
      console.log query
      @get('controller.controllers.articles').set('page', 1)
      @transitionTo 'articles', queryParams:
        q: query
        page: 1
