
module ::Persistence::Adapter::KyotoCabinet::Cursor::Interface

	################
	#  initialize  #
	################

	def initialize( parent_bucket, parent_index, cursor_instance )

		@parent_bucket = parent_bucket
    @parent_index = parent_index

    @cursor_instance = cursor_instance
    
	end
	
	###########
	#  close  #
	###########
	
	def close
	  
	  @cursor_instance.disable

  end
	
	################
	#  persisted?  #
	################

  # persisted? is responsible for setting the cursor position
	def persisted?( *args )

		has_key = false
		no_key  = false
		key = nil
		case args.count
		when 1
			key = args[0]
		when 0
			no_key = true
		end

		# if we have no args we are asking whether any keys exist
		if no_key
      
		  has_key = true unless ( @parent_index || @parent_bucket ).count == 0
		  
		else
      
      serialized_key = nil
      if @parent_index
        serialized_key = @parent_bucket.parent_adapter.class::SerializationClass.__send__( @parent_bucket.parent_adapter.class::SerializationMethod, key )
      else
        serialized_key = key
      end

      has_key = @cursor_instance.jump( serialized_key )

		end
		
		return has_key

	end

	###########
	#  first  #
	###########
	
	# first should set the cursor position and return the first ID or object hash
	def first
	  @cursor_instance.jump( nil )
		return current
	end

	###############
	#  first_key  #
	###############
	
	# first should set the cursor position and return the first ID or object hash
	def first_key
	  @cursor_instance.jump( nil )
		return current_key
	end

	#############
	#  current  #
	#############
	
	# current should return the current ID or object hash
	def current
		if global_id = @cursor_instance.get_value
		  global_id = global_id.to_i
	  end
		# return ID
		return global_id
	end

	#################
	#  current_key  #
	#################
	
	# current should return the current ID or object hash
	def current_key

    unserialized_key = nil

    if serialized_key_or_id_string = @cursor_instance.get_key

      # if we have an index we have serialized key
      if @parent_index
        unserialized_key = @parent_bucket.parent_adapter.class::SerializationClass.__send__( @parent_bucket.parent_adapter.class::UnserializationMethod, serialized_key_or_id_string )
      # if not we just have an ID string
      else
        unserialized_key = serialized_key_or_id_string.to_i
      end
    
    end
    
		# return ID
		return unserialized_key
		
	end

	##########
	#  next  #
	##########
	
	def next
	  @cursor_instance.step
		return current
	end

	##############
	#  next_key  #
	##############
	
	def next_key
	  @cursor_instance.step
		return current_key
	end
	  
end
