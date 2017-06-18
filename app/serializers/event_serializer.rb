class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start, :finish

  def attributes(*args)
    base_attributes = super
    base_attributes[:spots_left] = object.spots_left
    is_admin = instance_options[:admin] || false
    if is_admin
      base_attributes[:volunteer_count] = object.volunteer_count
      base_attributes[:min_volunteers] = object.min_volunteers
      base_attributes[:max_volunteers] = object.max_volunteers
    else
      base_attributes[:going] = object.instance_variable_get(:@going)
    end
    base_attributes
  end

end