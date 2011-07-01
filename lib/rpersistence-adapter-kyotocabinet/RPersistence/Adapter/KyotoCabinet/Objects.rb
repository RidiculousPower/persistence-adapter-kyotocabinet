# Rpersistence::Adapter::KyotoCabinet::Objects

module Rpersistence::Adapter::KyotoCabinet::Objects
	
  #################
  #  put_object!  #
  #################

  def put_object!( object )

    ensure_object_id( object )

		bucket( object.persistence_bucket ).put_object!( object )

    return self

  end

  ################
  #  get_object  #
  ################

  def get_object( global_id, bucket )
	
		return bucket( bucket ).get_object( global_id )
		
  end
  
  ####################
  #  delete_object!  #
  ####################

  def delete_object!( global_id, bucket )

    # delete the object info
    bucket( bucket ).delete_object!( global_id )
    
    # and delete the object's ID reference
    @database__primary_bucket_for_id.remove( global_id )
    
    return self

  end

end

