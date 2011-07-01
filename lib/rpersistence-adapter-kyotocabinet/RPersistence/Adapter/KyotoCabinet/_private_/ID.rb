# Rpersistence::Adapter::KyotoCabinet::ID

module Rpersistence::Adapter::KyotoCabinet::ID

  ###########################################################################################################
      private ###############################################################################################
  ###########################################################################################################

  ######################
  #  ensure_object_id  #
  ######################

  def ensure_object_id( object )
  
    unless object.persistence_id

      # we only store one sequence so we don't need a key; increment it by 1
			global_id = @database__id_sequence.increment( :sequence )

      # and write it to our global object database with a bucket/key struct as data
      @database__primary_bucket_for_id.set( global_id, object.persistence_bucket )

  		object.persistence_id = global_id
			
    end
  
    return self
  
  end
	
end
