class VolunteerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :mobile_number,
             :dob, :wwccn, :wwccn_status, :wwccn_expiry_date, :sub_newsletter, :uid
end
