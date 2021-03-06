Spree Home Page Features
========================

This adds a section to your spree home page where you can include 'features', which are basically news items.


Installation
------------

First add the reference to your gem file

```ruby
    # Gemfile
    gem 'spree_home_page_features', github: 'ricardoaandres/spree_home_page_features', branch: '3-0-stable'
```

`bundle install` your dependencies and run the installation generator:

```shell
    bundle install
    bundle exec rake spree_home_page_features:install
```

What can I add to a new feature?
--------------------------------

|Element    |Data type     |
|-----------|:------------:|
|Title      |string        |
|Description|text          |
|Image      |file          |
|Product    |Spree::Product|
|Taxon      |Spree::Taxon  |
|Published  |boolean       |


Styles
------

When you create a feature in the backend, you have the option of setting a style. This will add the style as class to the feature div. I intended this to be used to allow the site administrator select a backdrop for the article they are writing. To set the available styles in the dropdown, simply add the list of styles you would like available to a decorator in your models directory...

    # app/models/spree/home_page_feature_decorator.rb
    Spree::Banner.styles = ['style1', 'style2', 'etc']

You can then define a css file in your assets folder which define the styles...

    # app/assets/stylesheets/store/home_page_feature_styles.css
    li.feature.style1 { background-color: purple }
    li.feature.style2 { background-color: lime }
    li.feature.etc    { background-color: orange }

Testing
-------

First bundle your dependencies, then run `rake`. `rake` will build the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by running `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your application you will want to use its factories. Simply add this require statement to your spec_helper:

```ruby
require 'spree/spree_home_page_features/factories'
```
