
class Rpersistence::Adapter::KyotoCabinet::Cursor

	################
	#  initialize  #
	################

	def initialize( *args )

		@persistence_port, 
		@persistence_bucket, 
		@index, 
		@index_value = parse_cursor_initialization_args( args )

    # ask the adapter for the bucket and index
    @bucket_instance = @persistence_port.adapter.bucket( @persistence_bucket )
    @index_instance  = bucket_instance.index( @index ) if @index

    # if this is an index we iterate the index: serialized key => ID
    if @index_instance
      @cursor = @index_instance.cursor
    # if this is primary bucket we iterate ids_in_bucket database: ID => ID
    else
      @cursor = @bucket_instance.cursor
    end
    
    # if we have an index_value, jump to it
    if @index
      # if @index_value is nil and nil key does not exist, jump sets to first item
      @cursor.jump( @index_value )
    else
      @cursor.jump( nil )
    end
    
	end
	
	##############
	#  has_key?  #
	##############

  # has_key? is responsible for setting the cursor position
	def has_key?( *args )

		has_key = false
		no_key  = false
		case args.count
		when 1
			key = args[0]
		when 0
			no_key = true
		end

		# if we have no args we are asking whether any keys exist
		if no_key

			has_key = true unless @database.count == 0
			
		else

			# check if we have a position that currently points to key - if so we are done
			serialized_key_in_db = @cursor.get_key
			unserialized_key_in_db = adapter.class::SerializationClass.__send__( adapter.class::UnserializeMethod, serialized_key_in_db )
			return if has_key = ( unserialized_key_in_db == key )

      serialized_key = adapter.class::SerializationClass.__send__( adapter.class::SerializeMethod, key )
      has_key = cursor.jump( serialized_key )

		end
		
		return has_key

	end

	###########
	#  first  #
	###########
	
	# first should set the cursor position and return the first ID or object hash
	def first
	  @cursor.jump( nil )
		return current
	end

	#############
	#  current  #
	#############
	
	# current should return the current ID or object hash
	def current
		serialized_data_in_db = @cursor.get_value
		unserialized_data_in_db = adapter.class::SerializationClass.__send__( adapter.class::UnserializeMethod, serialized_data_in_db )
		# return ID
		return unserialized_data_in_db
	end

	##########
	#  next  #
	##########
	
	def next
	  @cursor.step
		return current
	end
	  
end
