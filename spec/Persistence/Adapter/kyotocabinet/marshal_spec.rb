
require_relative '../../../../lib/persistence/adapter/kyotocabinet.rb'

describe ::Persistence::Adapter::KyotoCabinet::Marshal do

  temp_test_path = "/tmp/persistence-kyotocabinet"
  
  ::FileUtils.rm_rf( temp_test_path ) if ::Dir.exist?( temp_test_path )

  $__persistence__spec__adapter__ = ::Persistence::Adapter::KyotoCabinet::Marshal.new( temp_test_path )

  # adapter spec
  require_relative File.join( ::Persistence::Adapter::Abstract.spec_location, 'Adapter_spec.rb' )

  ::FileUtils.rm_rf( temp_test_path ) if ::Dir.exist?( temp_test_path )

end
