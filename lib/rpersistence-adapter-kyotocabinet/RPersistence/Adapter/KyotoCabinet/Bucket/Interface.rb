
module Rpersistence::Adapter::KyotoCabinet::Bucket::Interface

  include Rpersistence::Adapter::KyotoCabinet::DatabaseSupport

  attr_accessor :parent_adapter, :name

	# we're always opening as writers and creating the files if they don't exist

  ################
  #  initialize  #
  ################
  
  def initialize( parent_adapter, bucket_name )

		@parent_adapter = parent_adapter
		@name = bucket_name

    # storage for index objects
    @indexes = { }

    # bucket database corresponding to self - holds properties
    # 
    # objectID             => klass
    # objectID.property_A  => property_value_A
    # objectID.property_B  => property_value_B
    # 
    @database__bucket = ::KyotoCabinet::DB.new
    @database__bucket.open( file__bucket_database( bucket_name ), 
                            @parent_adapter.class::DatabaseFlags )

    # holds IDs that are presently in this bucket so we can iterate objects normally
    # 
    # objectID => objectID
    #
    @database__ids_in_bucket = ::KyotoCabinet::DB.new
    @database__ids_in_bucket.open( file__ids_in_bucket_database( bucket_name ), 
                                   @parent_adapter.class::DatabaseFlags )
    
    # holds whether each index permits duplicates
    @database__index_permits_duplicates = ::KyotoCabinet::DB.new
    @database__index_permits_duplicates.open( file__index_permits_duplicates_database( bucket_name ), 
                                              @parent_adapter.class::DatabaseFlags )

  end
  
  ###########
  #  close  #
  ###########
  
  def close

    close_indexes

    @database__index_permits_duplicates.close

    super

  end

  ###################
  #  close_indexes  #
  ###################
  
  def close_indexes

    @indexes.each do |this_index_name, this_index_instance|
      this_index_instance.close
    end

  end

  ############
  #  cursor  #
  ############

  def cursor
    return Rpersistence::Adapter::KyotoCabinet::Cursor.new( self, nil, @database__ids_in_bucket.cursor )
  end

  #########################
  #  permits_duplicates?  #
  #########################
  
  def permits_duplicates?( index )

		permits_duplicates = @database__index_permits_duplicates.get( index )
		permits_duplicates = ( permits_duplicates == 1 ? true : false ) unless permits_duplicates.nil?

    return permits_duplicates

  end

  #################
  #  put_object!  #
  #################
  
  def put_object!( object )
    
    @parent_adapter.ensure_object_has_globally_unique_id( object )
    
    # insert object class definition: ID => klass
    # class definition is used as header/placeholder for object properties
    @database__bucket.set( object.persistence_id, object.class.to_s )

    # insert ID to cursor index
    @database__ids_in_bucket.set( object.persistence_id, object.persistence_id )

    # insert properties
    object.persistence_hash_to_port.each do |primary_key, attribute_value|
      put_attribute!( object.persistence_id, primary_key, attribute_value )
    end
    
    return object.persistence_id
    
  end
  
  ################
  #  get_object  #
  ################
  
  def get_object( global_id )

    object_persistence_hash = { }

    # create cursor and set to position of ID
    @database__bucket.cursor_process do |object_cursor|

      if object_cursor.jump( global_id )

        # Iterate until the key no longer begins with ID
        # First record (ID only, no attribute) points to klass, so we have to move forward to start.
        while this_attribute = next_attribute_of_this_object( object_cursor, global_id )

          serialized_value = object_cursor.get_value

          value = @parent_adapter.class::SerializationClass.__send__(  @parent_adapter.class::UnserializationMethod, serialized_value )
                    
          object_persistence_hash[ this_attribute ] = value

        end
      
      end

    end

    return object_persistence_hash.empty? ? nil : object_persistence_hash
    
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
        # First record (ID only, no attribute) points to klass, so we have to move forward to start.
        while this_attribute = next_attribute_of_this_object( object_cursor, global_id )

          this_attribute_value = object_cursor.get_value

					object_cursor.remove
        
        end
      
      end

    end
  
  end
  
  ####################
  #  put_attribute!  #
  ####################
  
  def put_attribute!( global_id, attribute_name, value )

    serialized_value  = @parent_adapter.class::SerializationClass.__send__( @parent_adapter.class::SerializationMethod, value )

    # set value for ID
    @database__bucket.set( attribute_name, serialized_value )

  end

  ###################
  #  get_attribute  #
  ###################
  
  def get_attribute( global_id, attribute_name )

    value = nil

    if serialized_value = @database__bucket.get( attribute_name )
      value = @parent_adapter.class::SerializationClass.__send__( @parent_adapter.class::UnserializationMethod, serialized_value )
    end

    return value

  end
  
  #######################
  #  delete_attribute!  #
  #######################
  
  def delete_attribute!( global_id, attribute_name )

    # delete primary info on attribute
    @database__bucket.remove( attribute_name )

  end

  ##################
  #  create_index  #
  ##################
  
  def create_index( index_name, permits_duplicates )

    # make sure index doesn't already exist with conflict duplicate permission
    unless ( permits_duplicates_value = permits_duplicates?( index_name ) ).nil?
			if ! permits_duplicates_value != ! permits_duplicates
	      raise 'Index on :' + index_name.to_s + ' already exists and ' + 
	            ( permits_duplicates ? 'does not permit' : 'permits' ) + ' duplicates, which conflicts.'
			end

    else

      @database__index_permits_duplicates.set( index_name, permits_duplicates )

    end

    # create/instantiate the index
    index_instance = Rpersistence::Adapter::KyotoCabinet::Bucket::Index.new( index_name,
                                                                             self,
                                                                             permits_duplicates )

    # store index instance
    @indexes[ index_name ] = index_instance

    return index_instance
    
  end

  ###########
  #  index  #
  ###########
  
  def index( index_name )

    return @indexes[ index_name ]

  end

  ##################
  #  delete_index  #
  ##################
  
  def delete_index( index_name )

    # remove permits_duplicates configuration
    @database__index_permits_duplicates.remove( index_name )

    index_instance = @indexes.delete( index_name )
    
    index_instance.delete
    
  end
  
  ################
  #  has_index?  #
  ################
  
  def has_index?( index_name )
    
    return @indexes.has_key?( index_name )

  end

  ###############
  #  get_class  #
  ###############

  def get_class( global_id )
    
    klass_path_string = @database__bucket.get( global_id )
    
    klass_path_parts = klass_path_string.split( '::' )

    klass = klass_path_parts.inject( Object ) do |object_container_namespace, next_path_part|
      object_container_namespace.const_get( next_path_part )
    end
    
    return klass
    
  end

  ###############
  #  get_class  #
  ###############

  def delete_class( global_id )
    
    @database__bucket.remove( global_id )

  end

  ####################################
  #  primary_key_for_attribute_name  #
  ####################################

  def primary_key_for_attribute_name( object, attribute )
    
		primary_key_for_bucket = object.persistence_id.to_s + @parent_adapter.class::Delimiter + attribute.to_s

		return primary_key_for_bucket

	end
  
  ##################################################################################################
      private ######################################################################################
  ##################################################################################################

  ###################################
  #  next_attribute_of_this_object  #
  ###################################

  def next_attribute_of_this_object( object_cursor, global_id )
		
		attribute_name = nil

    if object_cursor.step and
       primary_key = object_cursor.get_key

      this_global_id, this_attribute = primary_key.split( @parent_adapter.class::Delimiter )
    
      if this_global_id.to_i == global_id
			  attribute_name = this_attribute.to_sym
      end
		
		end
		
		return attribute_name

  end

	###########################
	#  file__bucket_database  #
	###########################

	def file__bucket_database( bucket_name )
	  
		return File.join( @parent_adapter.home_directory,
		                  bucket_name.to_s + extension__bucket_database )

	end

	##################################
	#  file__ids_in_bucket_database  #
	##################################

	def file__ids_in_bucket_database( bucket_name )

		return File.join( @parent_adapter.home_directory,
		                  bucket_name.to_s + '__ids_in_bucket__' + extension__ids_in_bucket_database )

	end	

	#############################################
	#  file__index_permits_duplicates_database  #
	#############################################

	def file__index_permits_duplicates_database( bucket_name )
	  
	  index_file_name = bucket_name.to_s + '__index_permits_duplicates__' + extension__index_permits_duplicates_database
	  
		return File.join( @parent_adapter.home_directory, index_file_name )

	end

	################################
	#  extension__bucket_database  #
	################################

	def extension__bucket_database
	  
		return extension__database( :tree )

	end

	###################################################
	#  extension__indexes_permit_duplicates_database  #
	###################################################

	def extension__indexes_permit_duplicates_database
	  
		return extension__database( :hash )

	end

	#######################################
	#  extension__ids_in_bucket_database  #
	#######################################

	def extension__ids_in_bucket_database
	  
		return extension__database( :hash )

	end

	##################################################
	#  extension__index_permits_duplicates_database  #
	##################################################
	
	def extension__index_permits_duplicates_database

		return extension__database( :hash )

	end
    
end
