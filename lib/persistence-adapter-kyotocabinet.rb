
require 'kyotocabinet'

if $__persistence__spec__development__
  require_relative '../../abstract/lib/persistence-adapter-abstract.rb'
else
  require 'persistence-adapter-abstract'
end

module ::Persistence
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

require_relative 'persistence-adapter-kyotocabinet/Persistence/Adapter/KyotoCabinet/DatabaseSupport.rb'

require_relative 'persistence-adapter-kyotocabinet/Persistence/Adapter/KyotoCabinet/Bucket/Index/Interface.rb'
require_relative 'persistence-adapter-kyotocabinet/Persistence/Adapter/KyotoCabinet/Bucket/Index.rb'
require_relative 'persistence-adapter-kyotocabinet/Persistence/Adapter/KyotoCabinet/Bucket/Interface.rb'
require_relative 'persistence-adapter-kyotocabinet/Persistence/Adapter/KyotoCabinet/Bucket.rb'

require_relative 'persistence-adapter-kyotocabinet/Persistence/Adapter/KyotoCabinet/Cursor/Interface.rb'
require_relative 'persistence-adapter-kyotocabinet/Persistence/Adapter/KyotoCabinet/Cursor.rb'

require_relative 'persistence-adapter-kyotocabinet/Persistence/Adapter/KyotoCabinet/Interface.rb'

require_relative 'persistence-adapter-kyotocabinet/Persistence/Adapter/KyotoCabinet.rb'
