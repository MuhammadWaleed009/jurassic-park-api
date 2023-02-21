require 'rails_helper'

RSpec.describe Cage, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:max_capacity) }
    it { should validate_numericality_of(:max_capacity).only_integer.is_greater_than(0) }
    it { should validate_presence_of(:power_status) }
    it { should define_enum_for(:power_status).with_values([:active, :down]).backed_by_column_of_type(:integer) }
 
    context 'when power status is down' do
      let(:cage) { create(:cage, power_status: :down) }

      it 'does not allow adding dinosaurs to the cage' do
        dinosaur = build(:dinosaur, cage: cage)
        expect(dinosaur).not_to be_valid
        expect(dinosaur.errors[:dinosaurs_count]).to include("Can't add into a cage with power status Down")
      end
    end
  end

  describe 'associations' do
    it { should have_many(:dinosaurs).dependent(:destroy) }
  end
end
