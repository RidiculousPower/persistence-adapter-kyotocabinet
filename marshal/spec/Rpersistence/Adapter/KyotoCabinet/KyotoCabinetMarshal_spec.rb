
if $__rpersistence__spec__development
  require_relative '../../../../../../../lib/rpersistence.rb'
  require_relative '../../../../lib/rpersistence-adapter-kyotocabinet-marshal.rb'
else
  require 'rpersistence'
  require 'rpersistence-adapter-kyotocabinet-marshal'
end

describe ::Rpersistence::Adapter::KyotoCabinet::KyotoCabinetMarshal do

  $__rpersistence__spec__adapter__ = ::Rpersistence::Adapter::KyotoCabinet::KyotoCabinetMarshal.new( "/tmp/rpersistence-kyotocabinet" )

  # adapter spec
  require_relative File.join( ::Rpersistence::Adapter.spec_location, 'Adapter_spec.rb' )

end
