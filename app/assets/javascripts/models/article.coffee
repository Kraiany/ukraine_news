UkraineNews.Article = DS.Model.extend
  title: DS.attr("string")
  source: DS.attr("string")
  canonical_url: DS.attr("string")
  content: DS.attr("string")
  published_at: DS.attr("date")
  body: Ember.computed.alias 'content'
  published_at_iso: Ember.computed 'published_at', ->
    if @get('published_at') then @get('published_at').toISOString() else ""
