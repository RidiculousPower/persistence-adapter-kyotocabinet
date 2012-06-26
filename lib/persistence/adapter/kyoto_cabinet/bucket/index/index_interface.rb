

module ::Persistence::Adapter::KyotoCabinet::Bucket::Index::IndexInterface

  include ::Persistence::Adapter::KyotoCabinet::DatabaseSupport

  ################
  #  initialize  #
  ################

  def initialize( index_name, parent_bucket, permits_duplicates )

    @name = index_name

    @parent_bucket = parent_bucket

    @permits_duplicates = permits_duplicates

    # get path info for index databases
    bucket_name    = @bucket_name

    @database__index = ::KyotoCabinet::DB.new
    @database__index.open( file__index_database( bucket_name, index_name ), 
                           parent_bucket.parent_adapter.class::DatabaseFlags )

    @database__reverse_index = ::KyotoCabinet::DB.new
    @database__reverse_index.open( file__reverse_index_database( bucket_name, index_name ), 
                                   parent_bucket.parent_adapter.class::DatabaseFlags )

  end

  ###########
  #  count  #
  ###########
  
  def count
    
    return @database__index.count
    
  end

  ###########
  #  close  #
  ###########
  
  def close
    
    @database__index.close
    @database__reverse_index.close

  end
  
  ############
  #  delete  #
  ############
  
  def delete
    
    # remove reverse index
    File.delete( @database__reverse_index.path )

    # remove index
    File.delete( @database__index.path )
    
  end
  
  ############
  #  cursor  #
  ############

  def cursor

    return ::Persistence::Adapter::KyotoCabinet::Cursor.new( @parent_bucket, self, @database__index.cursor )

  end

  #########################
  #  permits_duplicates?  #
  #########################
  
  def permits_duplicates?

    return @permits_duplicates

  end

  ###################
  #  get_object_id  #
  ###################

  def get_object_id( key )

    serialized_index_key = @parent_bucket.parent_adapter.class::SerializationClass.__send__( @parent_bucket.parent_adapter.class::SerializationMethod, key )

    global_id = @database__index.get( serialized_index_key )
    
    return global_id ? global_id.to_i : nil

  end
  
  #####################
  #  index_object_id  #
  #####################

  def index_object_id( global_id, key )

    serialized_index_key = @parent_bucket.parent_adapter.class::SerializationClass.__send__( @parent_bucket.parent_adapter.class::SerializationMethod, key )

    # we point to object.persistence_id rather than primary key because the object.persistence_id is the object header
    @database__index.set( serialized_index_key, global_id )
    @database__reverse_index.set( global_id, serialized_index_key )

  end

  ################################
  #  delete_keys_for_object_id!  #
  ################################

  def delete_keys_for_object_id!( global_id )

    serialized_key = @database__reverse_index.get( global_id )
    @database__reverse_index.remove( global_id )
    @database__index.remove( serialized_key )    

  end

  ##################################################################################################
      private ######################################################################################
  ##################################################################################################

  ##########################
  #  file__index_database  #
  ##########################

  def file__index_database( bucket_name, index_name )

    index_file_name = bucket_name.to_s + '__index_' + index_name.to_s + '__' + extension__bucket_index_database

    return File.join( @parent_bucket.parent_adapter.home_directory, index_file_name )

  end

  ##################################
  #  file__reverse_index_database  #
  ##################################

  def file__reverse_index_database( bucket_name, index_name )
    
    index_file_name = bucket_name.to_s + '__reverse_index_' + index_name.to_s + '__' + extension__bucket_index_database
    
    return File.join( @parent_bucket.parent_adapter.home_directory, index_file_name )

  end

  ######################################
  #  extension__bucket_index_database  #
  ######################################

  def extension__bucket_index_database
    
    return extension__database( :tree )

  end

end
