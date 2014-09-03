UkraineNews.ArticlesView = Ember.View.extend
  attributeBindings: ["style"]
  style: Ember.computed ->
    'height: 100%;'
  didInsertElement: ->
    jQuery("abbr.timeago").timeago()
