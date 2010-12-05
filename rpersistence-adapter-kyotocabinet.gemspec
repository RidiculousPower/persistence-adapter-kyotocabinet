require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'rpersistence-adapter-kyotocabinet'
  spec.rubyforge_project         =  'rpersistence-adapter-kyotocabinet'
  spec.version                   =  '0.0.1'

  spec.summary                   =  "RPersistence adapter for Kyoto Cabinet."
  spec.description               =  "Implements necessary methods to run RPersistence on top of Kyoto Cabinet."
  
  spec.authors                   =  [ 'Asher' ]
  spec.email                     =  'asher@ridiculouspower.com'
  spec.homepage                  =  'http://rubygems.org/gems/rpersistence-adapter-kyotocabinet'
  
  spec.date                      =  Date.today.to_s
  
  # ensure the gem is built out of versioned files
  # also make sure we include the bundle since we exclude it from git storage
  spec.files                     = Dir[ 'install.rb',
                                        '{lib,spec}/**/*',
                                        'README*', 
                                        'LICENSE*' ] & `git ls-files -z`.split("\0")

end
