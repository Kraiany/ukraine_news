UkraineNews.ArticlesController = Ember.ArrayController.extend Ember.Evented, InfiniteScroll.ControllerMixin,
  queryParams: ['q']
  q: null
  currentArticle: null
  actions:
    showNextItem: (args...) ->
      items = @get('content.content')
      current_item_index = items.indexOf @get('currentArticle')
      next_item = items[current_item_index + 1]
      @transitionToRoute('article', next_item) if next_item?
    showPreviousItem: (args...) ->
      items = @get('content.content')
      current_item_index = items.indexOf @get('currentArticle')
      next_item = items[current_item_index - 1]
      @transitionToRoute('article', next_item) if next_item?
    getTopPage: -> @store.find 'article', {page: 1}
    getMore: ->
      next_page = @get('page') + 1
      @store.find 'article',
        page: next_page
      .then (data) =>
        @set('page', data.meta.current_page)
