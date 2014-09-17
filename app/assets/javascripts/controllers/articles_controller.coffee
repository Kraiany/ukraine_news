UkraineNews.ArticlesController = Ember.ArrayController.extend
  queryParams: ['q']
  q: null
  currentArticle: null
  actions:
    showNextItem: (args...) ->
      items = @get('content.content')
      current_item_index = items.indexOf @get('currentArticle')
      next_item = items[current_item_index + 1]
      @transitionTo('article', next_item) if next_item?
    showPreviousItem: (args...) ->
      items = @get('content.content')
      current_item_index = items.indexOf @get('currentArticle')
      next_item = items[current_item_index - 1]
      @transitionTo('article', next_item) if next_item?
