# Rpersistence::Adapter::KyotoCabinet
#
# Rpersistence Adapter for Kyoto Cabinet

class Rpersistence::Adapter::KyotoCabinet

	include Rpersistence::Adapter::Abstract::Support::Initialize
	include Rpersistence::Adapter::Abstract::Support::ID
	include Rpersistence::Adapter::Abstract::Support::Enable
  include Rpersistence::Adapter::Abstract::Support::PrimaryKey::IDPropertyString

	include Rpersistence::Adapter::KyotoCabinet::ID
	include Rpersistence::Adapter::KyotoCabinet::Locations
	include Rpersistence::Adapter::KyotoCabinet::Objects
	include Rpersistence::Adapter::KyotoCabinet::Properties
	include Rpersistence::Adapter::KyotoCabinet::Indexes
	include Rpersistence::Adapter::KyotoCabinet::Database
	
  CursorClass = Rpersistence::Adapter::KyotoCabinet::Cursor

  Delimiter = '.'

  ################
  #  initialize  #
  ################

  def initialize( home_directory = nil )
	
		super( home_directory )

		@bucket_databases = Hash.new

  end

  ############
  #  enable  #
  ############

  def enable

    super

    # holds global ID sequence
    @database__id_sequence = ::KyotoCabinet::DB.new
    @database__id_sequence.open( filename__id_sequence_database, ::KyotoCabinet::DB::OWRITER | ::KyotoCabinet::DB::OCREATE )

    # holds global ID => primary bucket
    @database__primary_bucket_for_id = ::KyotoCabinet::DB.new
    @database__primary_bucket_for_id.open( filename__primary_bucket_for_id_database, ::KyotoCabinet::DB::OWRITER | ::KyotoCabinet::DB::OCREATE )

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

  ############
  #  bucket  #
  ############

  def bucket( bucket )
		bucket_instance = nil
		unless bucket_instance = @bucket_databases[ bucket ]
			bucket_instance = Rpersistence::Adapter::KyotoCabinet::Database::Bucket.new( self, bucket, filename__bucket_database( bucket ) )
			@bucket_databases[ bucket ] = bucket_instance
		end
		return bucket_instance
	end

end

