# Rpersistence::Adapter::KyotoCabinet::Locations
#
# DatabaseSupport for Rpersistence Adapter for Kyoto Cabinet

module Rpersistence::Adapter::KyotoCabinet::DatabaseSupport

  ##################################################################################################
      private ######################################################################################
  ##################################################################################################

	#########################
	#  extension__database  #
	#########################
	
	def extension__database( db_type )

		extension = nil
		
		case db_type
			when :hash
				# ".kch" - hash database (HashDB)
				extension = '.kch'
			when :tree
				# ".kct" - tree database (TreeDB)
				extension = '.kct'
			when :dir
				# ".kcd" - directory hash database (DirDB)
				extension = '.kcd'
			when :forest
				# ".kcf" - directory tree database (ForestDB)
				extension = '.kcf'
			else
				raise 'Unknown database type. Expected :hash, :tree, :dir, or :forest.'
		end
		
		return extension
		
	end
	
	#######################
	#  options__database  #
	#######################
	
	def options__database()
		
		# Compression:

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
		case db_type
			when :hash, :tree, :dir, :forest
			when :hash, :tree
			when :tree, :forest
		end

		# Tuning Parameters:

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

end
