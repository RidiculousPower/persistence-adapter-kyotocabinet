
module ::Rpersistence::Adapter::KyotoCabinet::Interface

	include ::Rpersistence::Adapter::Abstract::Interface::EnableDisable
  include ::Rpersistence::Adapter::Abstract::Interface::PrimaryKey::IDPropertyString

  include ::Rpersistence::Adapter::KyotoCabinet::DatabaseSupport

  DatabaseFlags = ::KyotoCabinet::DB::OWRITER | ::KyotoCabinet::DB::OCREATE

  Delimiter = '.'

  ################
  #  initialize  #
  ################

  def initialize( home_directory )
	
		super( home_directory )

		@buckets = { }

  end

  ############
  #  enable  #
  ############

  def enable

    super

    # holds global ID sequence
    @database__id_sequence = ::KyotoCabinet::DB.new
    @database__id_sequence.open( file__id_sequence_database, DatabaseFlags )

    # holds global ID => primary bucket
    @database__primary_bucket_for_id = ::KyotoCabinet::DB.new
    @database__primary_bucket_for_id.open( file__primary_bucket_for_id_database, DatabaseFlags )

    return self

  end

  #############
  #  disable  #
  #############

  def disable

    super

		@database__id_sequence.close
		@database__primary_bucket_for_id.close
		
    return self

  end

  ########################
  #  persistence_bucket  #
  ########################

  def persistence_bucket( bucket_name )
    
		bucket_instance = nil

		unless bucket_instance = @buckets[ bucket_name ]
			bucket_instance = ::Rpersistence::Adapter::KyotoCabinet::Bucket.new( self, bucket_name )
			@buckets[ bucket_name ] = bucket_instance
		end

		return bucket_instance

	end

  ###################################
  #  get_bucket_name_for_object_id  #
  ###################################

  def get_bucket_name_for_object_id( global_id )

    bucket_name = @database__primary_bucket_for_id.get( global_id )
    
    bucket_name = bucket_name.to_sym if bucket_name
      
    return bucket_name
  
  end

  #############################
  #  get_class_for_object_id  #
  #############################

  def get_class_for_object_id( global_id )

    bucket_name = get_bucket_name_for_object_id( global_id )

    bucket_instance = persistence_bucket( bucket_name )

    return bucket_instance.get_class( global_id )
  
  end

  #################################
  #  delete_bucket_for_object_id  #
  #################################

  def delete_bucket_for_object_id( global_id )

    return @database__primary_bucket_for_id.remove( global_id )
  
  end

  ################################
  #  delete_class_for_object_id  #
  ################################

  def delete_class_for_object_id( global_id )

    bucket_name = get_bucket_name_for_object_id( global_id )

    bucket_instance = persistence_bucket( bucket_name )

    return bucket_instance.delete_class( global_id )
  
  end

  ##########################################
  #  ensure_object_has_globally_unique_id  #
  ##########################################

  def ensure_object_has_globally_unique_id( object )
  
    unless object.persistence_id

      # we only store one sequence so we don't need a key; increment it by 1
			global_id = @database__id_sequence.increment( :sequence, 1, -1 )

      # and write it to our global object database with a bucket/key struct as data
      @database__primary_bucket_for_id.set( global_id, object.persistence_bucket.name )

  		object.persistence_id = global_id
			
    end
  
    return self
  
  end

  ##################################################################################################
      private ######################################################################################
  ##################################################################################################

	################################
	#  file__id_sequence_database  #
	################################

	def file__id_sequence_database

		return File.join( home_directory,
		                  'IDSequence' + extension__id_sequence_database )

	end

	##########################################
	#  file__primary_bucket_for_id_database  #
	##########################################

	def file__primary_bucket_for_id_database

		return File.join( home_directory,
		                  'PrimaryBucketForID' + extension__primary_bucket_for_id_database )
		                  
	end

	#####################################
	#  extension__id_sequence_database  #
	#####################################

	def extension__id_sequence_database
	  
		return extension__database( :tree )

	end

	###############################################
	#  extension__primary_bucket_for_id_database  #
	###############################################
	
	def extension__primary_bucket_for_id_database
	  
		return extension__database( :hash )

	end

end
