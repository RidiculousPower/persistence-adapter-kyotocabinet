
class ::Persistence::Adapter::KyotoCabinet::YAML

  include ::Persistence::Adapter::KyotoCabinet::AdapterInterface

  SerializationClass              =  ::YAML
  SerializationMethod             =  :dump
  UnserializationMethod           =  :load
  StringifyClassnames             =  true
  FileContentsAreTextNotBinary    =  true
  SerializationExtension          =  '.yaml'

end

