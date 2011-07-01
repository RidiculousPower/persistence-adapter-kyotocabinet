# Rpersistence::Adapter::KyotoCabinet::Properties

module Rpersistence::Adapter::KyotoCabinet::Properties

  ###################
  #  put_property!  #
  ###################

  def put_property!( object, property_name, property_value )
		database__bucket( object.persistence_bucket ).set_property( object.persistence_id, property_name, property_value )
    return self
  end

  ##################
  #  get_property  #
  ##################

  def get_property( object, property_name )
    return database__bucket( object.persistence_bucket ).get_property( object.persistence_id, property_name )
  end

  ######################
  #  delete_property!  #
  ######################

  def delete_property!( object, property_name )
    database__bucket( object.persistence_bucket ).delete_property!( object.persistence_id, property_name )
    return self
  end

  #######################
  #  complex_property?  #
  #######################

  def complex_property?( object, property_name )
    
    return database__bucket( object.persistence_bucket ).complex_property?( object.persistence_id, property_name )
    
  end

  ######################
  #  delete_cascades?  #
  ######################

  def delete_cascades?( object, property_name )
    
    return database__bucket( object.persistence_bucket ).delete_cascades?( object.persistence_id, property_name )
    
  end

end

