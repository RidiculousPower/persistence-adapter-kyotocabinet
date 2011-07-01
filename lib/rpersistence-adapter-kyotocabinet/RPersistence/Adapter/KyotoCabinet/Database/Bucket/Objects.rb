
module Rpersistence::Adapter::KyotoCabinet::Database::Bucket::Objects
  
  #################
  #  put_object!  #
  #################
  
  def put_object!( object )
    
    # insert object placeholder: ID => klass

    @database__bucket.set( object.persistence_id, object.class.to_s )

    # insert ID to cursor index
    @database__ids_in_bucket.set( object.persistence_id, object.persistence_id )
    # insert properties
    object.persistence_hash_to_port.each do |primary_key, property_value|
      set_property( object.persistence_id, primary_key, property_value )
    end
    
    return self
    
  end
  
  ################
  #  get_object  #
  ################
  
  def get_object( global_id )

    object_persistence_hash = Hash.new

    # create cursor and set to position of ID
    @database__bucket.cursor_process do |object_cursor|
      if object_cursor.jump( global_id )
        # Iterate until the key no longer begins with ID
        # First record (ID only, no property) points to klass, so we have to move forward to start.
        while this_property = next_property_of_this_object( object_cursor, global_id )
          serialized_value = object_cursor.get_value
          value = @adapter.class::SerializationClass.__send__(  @adapter.class::UnserializationMethod, serialized_value )
          # if we have a complex property, get object for value
          if complex_property?( global_id, this_property )
            sub_object_id     = value
            sub_object_bucket = parent_adapter.get_bucket_for_object_id( sub_object_id )
            sub_object_klass  = parent_adapter.bucket( sub_object_bucket ).get_class_for_object_id( sub_object_id )
            sub_object_hash   = parent_adapter.bucket( sub_object_bucket ).get_object( sub_object_id )
            value  = [ :__rpersistence__complex_object__, sub_object_klass, sub_object_hash ]
          end
          object_persistence_hash[ this_property ] = value
        
        end
      
      end

    end

    return object_persistence_hash
    
  end
  
  ####################
  #  delete_object!  #
  ####################
  
  def delete_object!( global_id )

    # delete from IDs in bucket database
    @database__ids_in_bucket.remove( global_id )

    # create cursor and set to position of ID
    @database__bucket.cursor_process do |object_cursor|

      if object_cursor.jump( global_id )
				
				object_cursor.remove
				
        # Iterate until the key no longer begins with ID
        # First record (ID only, no property) points to klass, so we have to move forward to start.
        while this_property = next_property_of_this_object( object_cursor, global_id )

          # if we have a complex property, get object for value
          if complex_property?( global_id, this_property ) and delete_cascades( global_id, this_property )
            sub_object_id     = object_cursor.get_value
            sub_object_bucket = get_bucket_for_object_id( sub_object_id )
            @adapter.delete_object!( sub_object_id, sub_object_bucket )
          end

					object_cursor.remove
        
        end
      
      end

    end
  
  end
  
end