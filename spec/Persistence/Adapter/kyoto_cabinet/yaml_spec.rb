
require_relative '../../../../lib/persistence/adapter/kyoto_cabinet.rb'

describe ::Persistence::Adapter::KyotoCabinet::YAML do

  temp_test_path = "/tmp/persistence-kyotocabinet"
  
  ::FileUtils.rm_rf( temp_test_path ) if ::Dir.exist?( temp_test_path )

  $__persistence__spec__adapter__ = ::Persistence::Adapter::KyotoCabinet::YAML.new( temp_test_path )

  # adapter spec
  require_relative File.join( ::Persistence::Adapter::Abstract.spec_location, 'Adapter_spec.rb' )

end
