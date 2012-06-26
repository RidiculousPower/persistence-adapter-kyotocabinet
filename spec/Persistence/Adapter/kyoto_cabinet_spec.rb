
require_relative '../../../lib/persistence/adapter/kyoto_cabinet.rb'

describe ::Persistence::Adapter::KyotoCabinet do
  
  temp_test_path = "/tmp/persistence-kyotocabinet"
  
  ::FileUtils.rm_rf( temp_test_path ) if ::Dir.exist?( temp_test_path )
    
  $__persistence__spec__adapter__ = ::Persistence::Adapter::KyotoCabinet.new( temp_test_path )

  # we have to specify a serialization class; we use Marshal for our example
  unless $__persistence__spec__development__initialized_kc
    class ::Persistence::Adapter::KyotoCabinet
      SerializationClass    =  ::Marshal
      SerializationMethod   =  :dump
      UnserializationMethod =  :load
    end
    $__persistence__spec__development__initialized_kc = true
  end
  
  # adapter spec
  require_relative File.join( ::Persistence::Adapter::Abstract.spec_location, 'Adapter_spec.rb' )

end
