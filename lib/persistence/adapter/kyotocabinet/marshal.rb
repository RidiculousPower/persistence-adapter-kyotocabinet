
class ::Persistence::Adapter::KyotoCabinet::Marshal

  include ::Persistence::Adapter::KyotoCabinet::AdapterInterface

  SerializationClass              =  ::Marshal
  SerializationMethod             =  :dump
  UnserializationMethod           =  :load
  StringifyClassnames             =  false
  FileContentsAreTextNotBinary    =  false
  SerializationExtension          =  '.ruby_marshal.bin'

end

