# ::Rpersistence::Adapter::KyotoCabinet
#
# ::Rpersistence Adapter for Kyoto Cabinet

class ::Rpersistence::Adapter::KyotoCabinet::KyotoCabinetMarshal

	include ::Rpersistence::Adapter::KyotoCabinet::Interface

  SerializationClass    =  Marshal
  SerializationMethod   =  :dump
  UnserializationMethod =  :load

end

