# Rpersistence::Adapter::KyotoCabinet::Locations
#
# Locations for Rpersistence Adapter for Kyoto Cabinet

module Rpersistence::Adapter::KyotoCabinet::Locations

  ###########################################################################################################
      private ###############################################################################################
  ###########################################################################################################

  ############################################ Filenames ####################################################

	####################################
	#  filename__id_sequence_database  #
	####################################

	def filename__id_sequence_database
		return home_directory + '/IDSequence' + extension__id_sequence_database
	end

	##############################################
	#  filename__primary_bucket_for_id_database  #
	##############################################

	def filename__primary_bucket_for_id_database
		return home_directory + '/PrimaryBucketForID' + extension__primary_bucket_for_id_database
	end

	###############################
	#  filename__bucket_database  #
	###############################

	def filename__bucket_database( bucket )
		return home_directory + '/' + bucket + extension__bucket_database
	end
	
	######################################
	#  filename__ids_in_bucket_database  #
	######################################

	def filename__ids_in_bucket_database( bucket )
		return home_directory + '/' + bucket + '__ids_in_bucket__' + extension__bucket_index_database
	end	

	###########################################
	#  filename__bucket_index_to_id_database  #
	###########################################

	def filename__bucket_index_to_id_database( bucket, index )
		return home_directory + '/' + bucket + '__index_on_' + index.to_s + '__' + extension__bucket_index_database
	end

	###########################################
	#  filename__id_to_bucket_index_database  #
	###########################################

	def filename__id_to_bucket_index_database( bucket, index )
		return home_directory + '/' + bucket + '__reverse_index_on_' + index.to_s + '__' + extension__bucket_index_database
	end

	#################################################
	#  filename__index_permits_duplicates_database  #
	#################################################

	def filename__index_permits_duplicates_database( bucket )
		return home_directory + '/' + bucket + '__index_permits_duplicates__' + extension__index_permits_duplicates_database
	end

	############################################
	#  filename__property_is_complex_database  #
	############################################
	
	def filename__property_is_complex_database( bucket )
		return home_directory + '/' + bucket + '__property_is_complex__' + extension__property_is_complex_database
	end

	########################################
	#  filename__delete_cascades_database  #
	########################################
	
	def filename__delete_cascades_database( bucket )
		
	end

  ############################################ Extensions ###################################################
	
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

	################################
	#  extension__bucket_database  #
	################################

	def extension__bucket_database
		return extension__database( :tree )
	end

	######################################
	#  extension__bucket_index_database  #
	######################################

	def extension__bucket_index_database
		return extension__database( :tree )
	end

	##################################################
	#  extension__index_permits_duplicates_database  #
	##################################################
	
	def extension__index_permits_duplicates_database
		return extension__database( :hash )
	end

	#############################################
	#  extension__property_is_complex_database  #
	#############################################
	
	def extension__property_is_complex_database
		return extension__database( :hash )
	end

	#########################################
	#  extension__delete_cascades_database  #
	#########################################
	
	def extension__delete_cascades_database
		return extension__database( :hash )
	end

	########################
	#  filename_extension  #
	########################
	
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

end
