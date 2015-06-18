# encoding: utf-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_home_page_features'
  s.version     = '3.0.0'
  s.summary     = 'Adds feature banners to the Spree home page'
  s.description = 'Allows you to manage banners in the spree admin, which will be displayed on your homepage'
  s.required_ruby_version = '>= 2.0.0'

  s.author    = ['Robert Oles', 'Ricardo Andrés Bello', 'Sebastián Vicencio']
  s.email     = ['robertoles@me.com', 'ricardoaandres@me.com', 'sivicencio@gmail.com']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 3.0'

  s.add_development_dependency 'capybara', '1.0.1'
  s.add_development_dependency 'factory_girl', '~> 2.6.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.9'
  s.add_development_dependency 'sqlite3'
end
