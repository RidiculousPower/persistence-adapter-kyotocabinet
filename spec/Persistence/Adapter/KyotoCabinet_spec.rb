
if $__persistence__spec__development__
  require_relative '../../../../../lib/persistence.rb'
  require_relative '../../../lib/persistence-adapter-kyotocabinet.rb'
else
  require 'persistence'
  require 'persistence-adapter-kyotocabinet'
end

describe ::Persistence::Adapter::KyotoCabinet do

  $__persistence__spec__adapter__ = ::Persistence::Adapter::KyotoCabinet.new( "/tmp/persistence-kyotocabinet" )

  # we have to specify a serialization class; we use Marshal for our example
  unless $__persistence__spec__development__initialized_kc
    class ::Persistence::Adapter::KyotoCabinet
      SerializationClass    =  Marshal
      SerializationMethod   =  :dump
      UnserializationMethod =  :load
    end
    $__persistence__spec__development__initialized_kc = true
  end
  
  # adapter spec
  require_relative File.join( ::Persistence::Adapter.spec_location, 'Adapter_spec.rb' )

end
