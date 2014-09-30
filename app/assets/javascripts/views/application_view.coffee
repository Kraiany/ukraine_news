UkraineNews.ApplicationView = Ember.View.extend
  gestures:
    tap: (event) ->
      @$(event.target).click()
      return false
