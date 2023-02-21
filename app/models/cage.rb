class Cage < ApplicationRecord
  has_many :dinosaurs, dependent: :destroy

  validates :max_capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :power_status, presence: true
  validate :power_down_not_with_dinosaurs, if: :down?

  enum power_status: { active: 0, down: 1 }

  private

  def power_down_not_with_dinosaurs
    if dinosaurs_count.positive?
      errors.add(:power_status, 'can\'t be set to DOWN while the cage contains dinosaurs')
    end
  end
end
