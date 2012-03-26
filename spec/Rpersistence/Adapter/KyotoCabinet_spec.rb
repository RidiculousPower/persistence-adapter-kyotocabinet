
if $__rpersistence__spec__development
  require_relative '../../../../../lib/rpersistence.rb'
  require_relative '../../../lib/rpersistence-adapter-kyotocabinet.rb'
else
  require 'rpersistence'
  require 'rpersistence-adapter-kyotocabinet'
end

describe ::Rpersistence::Adapter::KyotoCabinet do

  $__rpersistence__spec__adapter__ = ::Rpersistence::Adapter::KyotoCabinet.new( "/tmp/rpersistence-kyotocabinet" )

  # we have to specify a serialization class; we use Marshal for our example
  unless $__rpersistence__spec__development__initialized_kc
    class ::Rpersistence::Adapter::KyotoCabinet
      SerializationClass    =  Marshal
      SerializationMethod   =  :dump
      UnserializationMethod =  :load
    end
    $__rpersistence__spec__development__initialized_kc = true
  end
  
  # adapter spec
  require_relative File.join( ::Rpersistence::Adapter.spec_location, 'Adapter_spec.rb' )

end
