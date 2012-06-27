require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'persistence-adapter-kyotocabinet'
  spec.rubyforge_project         =  'persistence-adapter-kyotocabinet'
  spec.version                   =  '0.0.3'

  spec.summary                   =  "Adapter to use KyotoCabinet as storage port for Persistence."
  spec.description               =  "Implements necessary methods to run Persistence on top of Kyoto Cabinet."
  
  spec.authors                   =  [ 'Asher' ]
  spec.email                     =  'asher@ridiculouspower.com'
  spec.homepage                  =  'http://rubygems.org/gems/persistence-adapter-kyotocabinet'
  
  spec.add_dependency            'persistence'
  spec.add_dependency            'kyotocabinet'
  
  spec.date                      = Date.today.to_s
  
  spec.files                     = Dir[ '{lib,spec}/**/*',
                                        'README*', 
                                        'LICENSE*',
                                        'CHANGELOG*' ]

end
