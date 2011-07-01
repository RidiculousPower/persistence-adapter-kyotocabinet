
module Rpersistence::Adapter::KyotoCabinet::Database::Bucket::Properties
  
  ##################
  #  set_property  #
  ##################
  
  def set_property( global_id, primary_key_for_property, value )
    serialized_value  = @adapter.class::SerializationClass.__send__( @adapter.class::SerializationMethod, value )
    # set value for ID
    @database__bucket.set( primary_key_for_property, serialized_value )
  end

  ##################
  #  get_property  #
  ##################
  
  def get_property( global_id, primary_key_for_property )
    value = nil
    if serialized_value = @database__bucket.get( primary_key_for_property )
      value = @adapter.class::SerializationClass.__send__( @adapter.class::UnserializationMethod, serialized_value )
    end
    return value
  end
  
  ######################
  #  delete_property!  #
  ######################
  
  def delete_property!( global_id, primary_key_for_property )
    # delete primary info on property
    @database__bucket.remove( primary_key_for_property )
  end
  
end