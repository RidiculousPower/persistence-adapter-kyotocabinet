require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'persistence-adapter-kyotocabinet-marshal'
  spec.rubyforge_project         =  'persistence-adapter-kyotocabinet-marshal'
  spec.version                   =  '0.0.1'

  spec.summary                   =  "Persistence adapter for Kyoto Cabinet."
  spec.description               =  "Implements necessary methods to run ::Persistence on top of Kyoto Cabinet."
  
  spec.authors                   =  [ 'Asher' ]
  spec.email                     =  'asher@ridiculouspower.com'
  spec.homepage                  =  'http://rubygems.org/gems/persistence-adapter-kyotocabinet'
  
  spec.date                      =  Date.today.to_s
  
  # ensure the gem is built out of versioned files
  # also make sure we include the bundle since we exclude it from git storage
  spec.files                     = Dir[ 'lib/**/*',
                                        'spec/**/*',
                                        'README*', 
                                        'LICENSE*' ]

end
