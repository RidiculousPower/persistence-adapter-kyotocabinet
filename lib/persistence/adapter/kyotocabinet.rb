
require 'persistence'

require 'kyotocabinet'

require 'yaml'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

class ::Persistence::Adapter::KyotoCabinet
  
  include ::Persistence::Adapter::KyotoCabinet::AdapterInterface

end