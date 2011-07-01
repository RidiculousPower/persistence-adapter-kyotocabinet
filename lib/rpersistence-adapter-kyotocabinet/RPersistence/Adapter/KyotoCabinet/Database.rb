# Rpersistence::Adapter::KyotoCabinet::Database

module Rpersistence::Adapter::KyotoCabinet::Database

  ############################################# Database ####################################################

	######################
	#  database__bucket  #
	######################
	
	def database__bucket( bucket )
		
		bucket_instance = nil

		unless bucket_instance = @bucket_databases[ bucket ]
			bucket_instance = KyotoCabinet::DB.new
			bucket_instance.open( filename__bucket_database( bucket ), ::KyotoCabinet::DB::OWRITER | ::KyotoCabinet::DB::OCREATE )
			@bucket_databases[ bucket ] = bucket_instance
		end
		
    return bucket_instance

	end
	
	#####################
	#  database__index  #
	#####################
	
	def database__index( bucket, index )
		
		index_instance = nil

		bucket_indexes = ( @index_databases[ bucket ] ||= Hash.new )

		unless index_instance = bucket_indexes[ index ]
			index_instance = KyotoCabinet::DB.new
			index_instance.open( filename__bucket_index_to_id_database( bucket, index ), ::KyotoCabinet::DB::OWRITER | ::KyotoCabinet::DB::OCREATE )
			bucket_indexes[ index ] = index_instance
		end
		
    return index_instance
    
	end

	#############################
	#  database__reverse_index  #
	#############################
	
	def database__reverse_index( bucket, index )
		
		index_instance = nil

		bucket_indexes = ( @reverse_index_databases[ bucket ] ||= Hash.new )

		unless index_instance = bucket_indexes[ index ]
			index_instance = KyotoCabinet::DB.new
			index_instance.open( filename__id_to_bucket_index_database( bucket, index ), ::KyotoCabinet::DB::OWRITER | ::KyotoCabinet::DB::OCREATE )
			bucket_indexes[ index ] = index_instance
		end
		
    return index_instance
    
	end
	
	# Compression:
	#
	# All databases support:
	# * "opts"
	# * "zcomp"
	# * "zkey"
	# HashDB and TreeDB database also support:
	# * "apow"
	# * "fpow"
	# * "bnum"
	# * "msiz"
	# * "dfunit"
	# TreeDB and ForestDB also support:
	# * "psiz"
	# * "rcomp"
	# * "pccap"

	# Tuning Parameters:
	#
	# * "log" is for the original "tune_logger" and the value specifies:
	#   - the path of the log file
	#   - "-" for stdout
	#   - "+" for stderr 
	# * "logkinds" specifies kinds of logged messages and the value can be:
	#   - "debug"
	#   - "info"
	#   - "warn"
	#   - "error"
	# * "logpx" specifies the prefix of each log message.
	# * "opts" is for "tune_options" and the value can contain:
	#   - "s" for the small option
	#   - "l" for the linear option
	#   - "c" for the compress option
	# * "bnum" corresponds to "tune_bucket".
	# * "zcomp" is for "tune_compressor":
	#   - "zlib" for the ZLIB raw compressor
	#   - "def" for the ZLIB deflate compressor
	#   - "gz" for the ZLIB gzip compressor
	#   - "lzo" for the LZO compressor
	#   - "lzma" for the LZMA compressor
	#   - "arc" for the Arcfour cipher
	# * "zkey" specifies the cipher key of the compressor.
	# * "capcnt" is for "cap_count".
	# * "capsiz" is for "cap_size".
	# * "psiz" is for "tune_page".
	# * "rcomp" is for "tune_comparator" and the value can be:
	#   - "lex" for the lexical comparator
	#   - "dec" for the decimal comparator
	# * "pccap" is for "tune_page_cache".
	# * "apow" is for "tune_alignment".
	# * "fpow" is for "tune_fbp".
	# * "msiz" is for "tune_map".
	# * "dfunit" is for "tune_defrag".

end
