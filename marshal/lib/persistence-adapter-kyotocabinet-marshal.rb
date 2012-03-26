
require 'kyotocabinet'

if $__persistence__spec__development__
  require_relative '../../lib/persistence-adapter-kyotocabinet.rb'
else
  require 'persistence-adapter-kyotocabinet'
end

module ::Persistence
  module Adapter
    class KyotoCabinet
      class KyotoCabinetMarshal
      end
    end
  end
end

require_relative 'persistence-adapter-kyotocabinet-marshal/Persistence/Adapter/KyotoCabinet/KyotoCabinetMarshal.rb'
