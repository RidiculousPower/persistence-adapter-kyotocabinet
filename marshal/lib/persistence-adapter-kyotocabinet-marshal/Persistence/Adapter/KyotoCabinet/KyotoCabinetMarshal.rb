# ::Persistence::Adapter::KyotoCabinet
#
# ::Persistence Adapter for Kyoto Cabinet

class ::Persistence::Adapter::KyotoCabinet::KyotoCabinetMarshal

	include ::Persistence::Adapter::KyotoCabinet::Interface

  SerializationClass    =  Marshal
  SerializationMethod   =  :dump
  UnserializationMethod =  :load

end

