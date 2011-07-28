
module Rpersistence::Adapter::KyotoCabinet::Database::Bucket::Indexes
  
  ##################
  #  create_index  #
  ##################
  
  def create_index( property, permits_duplicates )
    # make sure index doesn't already exist with conflict duplicate permission
    unless ( permits_duplicates_value = permits_duplicates?( property ) ).nil?
			if permits_duplicates_value != permits_duplicates
	      raise 'Index on :' + property.to_s + ' already exists and ' + 
	            ( permits_duplicates ? 'does not permit' : 'permits' ) + ' duplicates, which conflicts.'
			end
    else
      @database__index_permits_duplicates.set( property, permits_duplicates )
    end
    # create/instantiate the index
    index_instance = KyotoCabinet::DB.new
    # create/instantiate the reverse index
    reverse_index_instance = KyotoCabinet::DB.new
		bucket_name    = @bucket_name
		database_flags = @database_flags
		@adapter.instance_eval do
	    index_instance.open( filename__bucket_index_to_id_database( bucket_name, property ), database_flags )
	    reverse_index_instance.open( filename__id_to_bucket_index_database( bucket_name, property ), database_flags )
		end
    # store index instances
    @indexes[ property ] = index_instance
    @reverse_indexes[ property ] = reverse_index_instance
  end

  ##################
  #  delete_index  #
  ##################
  
  def delete_index( property )
    # remove permits_duplicates configuration
    @database__index_permits_duplicates.remove( property )
    # remove reverse index
    File.delete( @reverse_indexes.delete( property ).path )
    # remove index
    File.delete( @indexes.delete( property ).path )
  end
  
  ################
  #  has_index?  #
  ################
  
  def has_index?( property )
    return ( @database__index_permits_duplicates.get( property ) != nil ? true : false )
  end

  #########################
  #  permits_duplicates?  #
  #########################
  
  def permits_duplicates?( property )
		permits_duplicates = @database__index_permits_duplicates.get( property )
		permits_duplicates = ( permits_duplicates == 1 ? true : false ) unless permits_duplicates.nil?
    return permits_duplicates
  end
  
  ###########
  #  index  #
  ###########
  
  def index( property )
    raise 'Index on :' + property + 'has not been defined.' unless has_index?( property )
    return @indexes[ property ]
  end

  ###################
  #  reverse_index  #
  ###################
  
  def reverse_index( property )
    raise 'Index on :' + property + 'has not been defined.' unless has_index?( property )
    return @reverse_indexes[ property ]
  end

  ############################
  #  index_property_for_object  #
  ############################

	def index_property_for_object( object, index, value )
	  serialized_index_key = @adapter.class::SerializationClass.__send__( @adapter.class::SerializationMethod, value )
	  # we point to object.persistence_id rather than primary key because the object.persistence_id is the object header
	  index( index ).set( serialized_index_key, object.persistence_id )
	  reverse_index( index ).set( object.persistence_id, serialized_index_key )
	end

  ##############################
  #  delete_index_for_object!  #
  ##############################
	
	def delete_index_for_object!( object, index )
		reverse_index_db = reverse_index( index )
	  serialized_key = reverse_index_db.get( object.persistence_id )
		reverse_index_db.remove( object.persistence_id )
		index( index ).remove( serialized_key )	  
	end
  
end