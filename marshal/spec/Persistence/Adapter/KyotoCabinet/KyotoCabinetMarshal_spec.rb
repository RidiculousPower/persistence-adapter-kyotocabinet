
if $__persistence__spec__development__
  require_relative '../../../../../../../lib/persistence.rb'
  require_relative '../../../../lib/persistence-adapter-kyotocabinet-marshal.rb'
else
  require 'persistence'
  require 'persistence-adapter-kyotocabinet-marshal'
end

describe ::Persistence::Adapter::KyotoCabinet::KyotoCabinetMarshal do

  $__persistence__spec__adapter__ = ::Persistence::Adapter::KyotoCabinet::KyotoCabinetMarshal.new( "/tmp/persistence-kyotocabinet" )

  # adapter spec
  require_relative File.join( ::Persistence::Adapter.spec_location, 'Adapter_spec.rb' )

end
