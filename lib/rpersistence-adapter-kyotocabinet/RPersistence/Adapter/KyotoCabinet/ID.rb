# Rpersistence::Adapter::KyotoCabinet::ID

module Rpersistence::Adapter::KyotoCabinet::ID

  ############################################
  #  get_object_id_for_bucket_index_and_key  #
  ############################################

  def get_object_id_for_bucket_index_and_key( bucket, index, key )

		serialized_key = self.class::SerializationClass.__send__( self.class::SerializationMethod, key )
		global_id = database__bucket( bucket ).index( index ).get( serialized_key )
		global_id = global_id.to_i if global_id

  	return global_id

  end

  ##############################
  #  get_bucket_for_object_id  #
  ##############################

  def get_bucket_for_object_id( global_id )

    return @database__primary_bucket_for_id.get( global_id )
  
  end

  #############################
  #  get_class_for_object_id  #
  #############################

  def get_class_for_object_id( global_id )

    return database__bucket( get_bucket_for_object_id( global_id ) ).get_class( global_id )
  
  end

end
