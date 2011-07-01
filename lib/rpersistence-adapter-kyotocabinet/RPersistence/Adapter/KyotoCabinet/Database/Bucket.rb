
class Rpersistence::Adapter::KyotoCabinet::Database::Bucket
  
  include Rpersistence::Adapter::KyotoCabinet::Database::Bucket::ID
  include Rpersistence::Adapter::KyotoCabinet::Database::Bucket::Indexes
  include Rpersistence::Adapter::KyotoCabinet::Database::Bucket::Objects
  include Rpersistence::Adapter::KyotoCabinet::Database::Bucket::Properties
    
  ################
  #  initialize  #
  ################
  
  def initialize( adapter, bucket_name, directory )

    super( directory, ::KyotoCabinet::DB::OWRITER | ::KyotoCabinet::DB::OCREATE )

		@adapter     = adapter
		@bucket_name = bucket_name

    @indexes          = Hash.new
    @reverse_indexes  = Hash.new

		# we're always opening as writers and creating the files if they don't exist
		@database_flags = ::KyotoCabinet::DB::OWRITER | ::KyotoCabinet::DB::OCREATE

		filename__bucket                   = nil
		filename__ids_in_bucket            = nil
		filename__index_permits_duplicates = nil
		filename__property_is_complex      = nil
		filename__delete_cascades          = nil
		# get filenames from private methods in adapter
		adapter.instance_eval do
			filename__bucket                   = filename__bucket_database( bucket_name )
			filename__ids_in_bucket            = filename__ids_in_bucket_database( bucket_name )
			filename__index_permits_duplicates = filename__index_permits_duplicates_database( bucket_name )
			filename__property_is_complex      = filename__property_is_complex_database( bucket_name )
			filename__delete_cascades          = filename__delete_cascades_database( bucket_name )
		end

    # bucket - holds properties
    @database__bucket = KyotoCabinet::DB.new
    @database__bucket.open( filename__bucket, @database_flags )

    # holds IDs that are presently in this bucket so we can iterate objects normally
    @database__ids_in_bucket = KyotoCabinet::DB.new
    @database__ids_in_bucket.open( filename__ids_in_bucket, @database_flags )
    
    # holds whether each index permits duplicates
    @database__index_permits_duplicates = KyotoCabinet::DB.new
    @database__index_permits_duplicates.open( filename__index_permits_duplicates, @database_flags )

    # holds whether each property is complex
    @database__property_is_complex = KyotoCabinet::DB.new
    @database__property_is_complex.open( filename__property_is_complex, @database_flags )

    # holds whether each property cascades for deletion
    @database__delete_cascades = KyotoCabinet::DB.new
    @database__delete_cascades.open( filename__delete_cascades, @database_flags )

  end
  
  ###########
  #  close  #
  ###########
  
  def close
    close_indexes
    @database__index_permits_duplicates.close
    @database__property_is_complex.close
    @database__delete_cascades.close
    super
  end

  ###################
  #  close_indexes  #
  ###################
  
  def close_indexes
    ( @indexes.values + @reverse_indexes.values ).each do |this_index_instance|
      this_index_instance.close
    end
  end

  #######################
  #  complex_property?  #
  #######################

  def complex_property?( global_id, property_name )
    
    primary_key = global_id.to_s + @adapter.class::Delimiter + property_name.to_s

    return ( @database__property_is_complex.get( primary_key == 1 ) ? true : false )
    
  end

  ######################
  #  delete_cascades?  #
  ######################

  def delete_cascades?( global_id, property_name )
    
    primary_key = global_id.to_s + @adapter.class::Delimiter + property.to_s

    return ( @database__delete_cascades.get( primary_key ) ? true : false )
    
  end
    
end