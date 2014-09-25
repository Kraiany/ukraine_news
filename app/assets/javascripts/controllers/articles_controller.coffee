UkraineNews.ArticlesController = Ember.ArrayController.extend Ember.Evented,
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
