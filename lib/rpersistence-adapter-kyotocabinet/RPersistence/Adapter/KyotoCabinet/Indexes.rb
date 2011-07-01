# Rpersistence::Adapter::KyotoCabinet::Indexes

module Rpersistence::Adapter::KyotoCabinet::Indexes

  ################
  #  has_index?  #
  ################
  
  def has_index?( klass, index )
    return database__bucket( klass.instance_persistence_bucket ).has_index?( index )
  end

  ###############################
  #  index_permits_duplicates?  #
  ###############################

  def index_permits_duplicates?( klass, index )
    return database__bucket( klass.instance_persistence_bucket ).permits_duplicates?( index )
  end

  ##################
  #  create_index  #
  ##################

  def create_index( klass, index, permits_duplicates )
    database__bucket( klass.instance_persistence_bucket ).create_index( index, permits_duplicates )
  end

  ##################
  #  delete_index  #
  ##################

  def delete_index( klass, index )
    database__bucket( klass.instance_persistence_bucket ).delete_index( index )
  end

  ############################
  #  index_object_attribute  #
  ############################

  def index_object_attribute( object, index, value )
    database__bucket( object.persistence_bucket ).index_object_attribute( object, index, value )
  end

  #############################
  #  delete_index_for_object  #
  #############################

  def delete_index_for_object( bucket, index, global_id )
    database__bucket( klass.instance_persistence_bucket ).delete_index_for_object( index, global_id )
  end

end
