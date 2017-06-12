class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_date, :end_date

  def attributes(*args)
    base_attributes = super
    is_admin = instance_options[:admin] || false
    if is_admin
      base_attributes[:volunteer_count] = object.volunteer_count
    else
      base_attributes[:going] = object.instance_variable_get(:@going)
    end
    base_attributes
  end

end