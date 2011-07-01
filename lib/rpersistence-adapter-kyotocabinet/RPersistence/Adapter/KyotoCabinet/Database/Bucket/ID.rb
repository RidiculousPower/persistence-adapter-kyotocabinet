
module Rpersistence::Adapter::KyotoCabinet::Database::Bucket::ID
  
  ###############
  #  get_class  #
  ###############

  def get_class( global_id )
    
    klass_string = @database__bucket.get( global_id )
    klass = klass_string.split( '::' ).inject( Object ) { |namespace, next_part| namespace.const_get( next_part ) }
    
    return klass
    
  end
  
end