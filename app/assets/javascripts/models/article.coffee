UkraineNews.Article = DS.Model.extend
  title: DS.attr("string")
  canonical_url: DS.attr("string")
  content: DS.attr("string")
  published_at: DS.attr("date")