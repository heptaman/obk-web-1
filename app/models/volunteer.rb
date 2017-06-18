class Volunteer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  include DeviseTokenAuth::Concerns::User

  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :events

  validates :first_name, :last_name, :email, :dob, :mobile_number, :gender, presence: true
  validates :email, email: true, uniqueness: true
  validates :gender, inclusion: { in: %w(M F O) }
  validates :wwccn, presence: true, if: ['!dob.nil?', :more_than_eighteen?]

  def self.add(params = {})
    v = Volunteer.find_or_create_by params.slice(:first_name, :last_name, :email, :dob)
    unless v.nil?
      v.password = v.password_confirmation = params[:password]
      v.mobile_number = params[:mobile_number]
      v.gender = params[:gender]
      v.wwccn = params[:wwccn]
      v.wwccn_status = params[:wwccn_status]
      v.wwccn_expiry_date = params[:wwccn_expiry_date]
      v.save
    end
    v
  end

  def full_name
    "#{first_name} #{last_name}".trim
  end

  def as_json(options = nil)
    ActiveModelSerializers::SerializableResource.new(self).as_json
  end

  private

  def more_than_eighteen?
    (Time.zone.today.year - dob.to_date.year) >= 18
  end
end