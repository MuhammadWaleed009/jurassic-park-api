require 'rails_helper'

RSpec.describe Dinosaur, type: :model do
  let(:cage) { create(:cage) }
  let(:dinosaur) { create(:dinosaur) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:species) }
    it { should define_enum_for(:species).with_values([:tyrannosaurus, :velociraptor, :spinosaurus, :megalosaurus, :brachiosaurus, :stegosaurus, :ankylosaurus, :triceratops]).backed_by_column_of_type(:integer) }
    it { should define_enum_for(:diet).with_values([:carnivore, :herbivore]).backed_by_column_of_type(:integer) }
  end

  describe 'associations' do
    it { should belong_to(:cage) }
  end

  describe 'callbacks' do
    describe '#set_diet' do
      it 'sets the diet based on the species' do
        dino = create(:dinosaur, species: 'tyrannosaurus')
        expect(dino.diet).to eq('carnivore')
      end
    end
  end

  describe 'custom validations' do

    describe '#dinosaurs_count_within_max_capacity' do
      let(:full_cage) { create(:cage, max_capacity: 2) }

      it 'does not allow adding dinosaurs beyond the max capacity' do
        create(:dinosaur, cage: full_cage)
        create(:dinosaur, cage: full_cage)
        dino2 = build(:dinosaur, cage: full_cage)
        expect(dino2.valid?).to be(false)
        expect(dino2.errors[:dinosaurs_count]).to include("Exceeds maximum capacity of the cage")
      end
    end

    describe '#power_status_check' do
      let(:down_cage) { create(:cage, power_status: 'down') }

      it 'does not allow adding dinosaurs to a cage with power status DOWN' do
        dino = build(:dinosaur, cage: down_cage)
        expect(dino).not_to be_valid
        expect(dino.errors[:dinosaurs_count]).to include("Can't add into a cage with power status Down")
      end
    end
  end
end
