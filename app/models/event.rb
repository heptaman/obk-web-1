class Event < ApplicationRecord
  validate :expiration_date_cannot_be_in_the_past

  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :volunteers

  validates :title, :start, :finish, presence: true

  scope :upcoming, -> { where('start >= :now', now: Time.zone.now).order(start: 'asc') }

  scope :past, -> { where('finish < :now', now: Time.zone.now).order(start: 'desc') }

  def expiration_date_cannot_be_in_the_past
    if start.present? && start < Time.zone.today
      errors.add(:start, "cannot be in the past")
    end
  end

  def expired?
    finish < Time.zone.today
  end

  # only used to flag if a volunteer has subscribed to this event
  def going!
    @going = true
  end

  def spots_left
    max_volunteers - volunteers.count
  end

end
