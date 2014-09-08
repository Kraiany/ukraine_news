UkraineNews.ArticlesView = Ember.View.extend
  attributeBindings: ["style"]
  style: Ember.computed ->
    'height: 100%;'
  didInsertElement: ->
    jQuery("abbr.timeago").timeago()
  articleIsShown: Ember.computed 'controller.target.url', ->
    /^\/articles\/[0-9]+$/.test @get('controller.target.url')
