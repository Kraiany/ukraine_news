[![Build Status](https://travis-ci.org/Kraiany/ukraine_news.svg)](https://travis-ci.org/Kraiany/ukraine_news)
![Build Status](https://codeship.com/projects/97b3cf70-64bf-0132-41dc-1a1c11ba4c94/status?branch=master)

### Setup

1. Confiure database file `cp config/database.sample.yml config/database.yml`
1. Install dependencies `bundle install`
1. Setup your database `rake db:setup` or `rake db:create; rake db:migrate; rake db:seed`
1. Start server `rails server`

### Scraping news

`rake scrape:all`

### Supported News Outlets

1. [Українська правда](http://www.pravda.com.ua/)
1. [Еспресо](http://espreso.tv/news)
1. [Громадське](http://www.hromadske.tv/news/)


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/Kraiany/ukraine_news/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

