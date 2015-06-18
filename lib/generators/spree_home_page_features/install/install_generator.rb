module SpreeHomePageFeatures
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_javascripts
        res = ask 'Would you like to append spree_home_page_features to the JS manifest? [Y/n]'
         if res == '' || res.downcase == 'y'
          append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_home_page_features\n"
         else
          puts "Don't forget to require and initialize Flexslider dependency. Use of Bower highly recommended"
         end
      end

      def add_stylesheets
        res = ask 'Would you like to append spree_home_page_features to the CSS manifest? [Y/n]'
        if res == '' || res.downcase == 'y'
          inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', "*= require spree/frontend/spree_home_page_features\n", :before => /\*\//, :verbose => true
        else
          puts "Don't forget to add your own styles to the slider. You can also use the Flexslider base styles (use of Bower highly recommended)"
        end
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_home_page_features'
      end

      def run_migrations
        res = ask 'Would you like to run the migrations now? [Y/n]'
        if res == '' || res.downcase == 'y'
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
