require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'persistence-adapter-kyotocabinet'
  spec.rubyforge_project         =  'persistence-adapter-kyotocabinet'
  spec.version                   =  '0.0.1'

  spec.summary                   =  "Persistence adapter for Kyoto Cabinet."
  spec.description               =  "Implements necessary methods to run Persistence on top of Kyoto Cabinet."
  
  spec.authors                   =  [ 'Asher' ]
  spec.email                     =  'asher@ridiculouspower.com'
  spec.homepage                  =  'http://rubygems.org/gems/persistence-adapter-kyotocabinet'
  
  spec.add_dependency            'persistence'
  
  spec.date                      = Date.today.to_s
  
  spec.files                     = Dir[ '{lib,spec}/**/*',
                                        'README*', 
                                        'LICENSE*',
                                        'CHANGELOG*' ]

end
