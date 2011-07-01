$__rpersistence__spec__development = true

require 'kyotocabinet'

if $__rpersistence__spec__development
  require_relative '../../lib/rpersistence-adapter-abstract.rb'
else
  require 'rpersistence-adapter-abstract'
end

module Rpersistence
  module Adapter
    class KyotoCabinet
      module Database
        class Bucket
          module ID
          end
          module Indexes
          end
          module Objects
          end
          module Properties
          end
        end
      end
      class Cursor
      end
			module Locations
			end
      module Enable
      end
      module ID
      end
      module Indexes
      end
      module Objects
      end
      module Properties
      end
    end
  end
end

require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/_private_/Locations.rb'

require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Database.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Database/Bucket.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Database/_private_/Bucket.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Database/Bucket/ID.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Database/Bucket/Indexes.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Database/Bucket/Objects.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Database/Bucket/Properties.rb'

require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/ID.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/_private_/ID.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Indexes.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Objects.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Properties.rb'
