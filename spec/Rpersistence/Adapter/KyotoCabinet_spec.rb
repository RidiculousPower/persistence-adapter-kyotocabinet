$__rpersistence__spec__development = true

if $__rpersistence__spec__development
  require_relative '../../../../../lib/rpersistence.rb'
  require_relative '../../../lib/rpersistence-adapter-kyotocabinet.rb'
else
  require 'rpersistence'
  require 'rpersistence-adapter-kyotocabinet'
end

describe Rpersistence::Adapter::KyotoCabinet do

  $__rpersistence__spec__adapter_test_class__     = Rpersistence::Adapter::KyotoCabinet
  $__rpersistence__spec__adapter_home_directory__ = "/tmp/rpersistence-kyotocabinet"

  # we have to specify a serialization class; we use Marshal for our example
  class Rpersistence::Adapter::KyotoCabinet
    SerializationClass    =  Marshal
    SerializationMethod   =  :dump
    UnserializationMethod =  :load
  end

  # adapter spec
  require Rpersistence::Adapter.spec_location

end
