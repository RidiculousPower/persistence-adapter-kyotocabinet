
class Rpersistence::Adapter::KyotoCabinet::Database::Bucket

  ##################################
  #  next_property_of_this_object  #
  ##################################

  def next_property_of_this_object( object_cursor, global_id )
		
		property_name = nil

    if object_cursor.step       &&
       ( primary_key = object_cursor.get_key ) != nil

      this_global_id, this_property = primary_key.split( @adapter.class::Delimiter )
			property_name = this_property.to_sym if this_global_id.to_i == global_id

		end
		
		return property_name

  end

  ########################
  #  primary_bucket_key  #
  ########################

  def primary_bucket_key( global_id, property )
		primary_key_for_bucket = global_id.to_s + @adapter.class::Delimiter + property.to_s
		return primary_key_for_bucket
	end

end
