$__rpersistence__spec__development = true

require 'kyotocabinet'

if $__rpersistence__spec__development
  require_relative '../../abstract/lib/rpersistence-adapter-abstract.rb'
else
  require 'rpersistence-adapter-abstract'
end

module Rpersistence
  module Adapter
    class KyotoCabinet
      module Interface
      end
      class Cursor
        module Interface
        end
      end
      class Bucket
        module Interface
        end
        class Index
          module Interface
          end
        end
      end
    end
  end
end

require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/DatabaseSupport.rb'

require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Bucket/Index/Interface.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Bucket/Index.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Bucket/Interface.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Bucket.rb'

require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Cursor/Interface.rb'
require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Cursor.rb'

require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet/Interface.rb'

require_relative 'rpersistence-adapter-kyotocabinet/Rpersistence/Adapter/KyotoCabinet.rb'
