UkraineNews.ApplicationRoute = Ember.Route.extend
  actions:
    search: (query) ->
      console.log query
      @transitionTo 'articles', queryParams:
        q: query
