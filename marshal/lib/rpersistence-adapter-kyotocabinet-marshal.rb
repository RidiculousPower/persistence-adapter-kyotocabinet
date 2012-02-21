
require 'kyotocabinet'

if $__rpersistence__spec__development
  require_relative '../../lib/rpersistence-adapter-kyotocabinet.rb'
else
  require 'rpersistence-adapter-kyotocabinet'
end

module Rpersistence
  module Adapter
    class KyotoCabinet
      class KyotoCabinetMarshal
      end
    end
  end
end

require_relative 'rpersistence-adapter-kyotocabinet-marshal/Rpersistence/Adapter/KyotoCabinet/KyotoCabinetMarshal.rb'
