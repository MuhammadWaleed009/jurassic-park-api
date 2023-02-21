class Dinosaur < ApplicationRecord
  belongs_to :cage, counter_cache: true

  validates :name, :species, presence: true
  validate :carnivore_only_with_same_species, if: -> { cage && cage.dinosaurs.any? }
  validate :dinosaurs_count_within_max_capacity, :power_status_check, if: -> { cage }

  enum diet: { carnivore: 0, herbivore: 1 }
  enum species: { tyrannosaurus: 0, velociraptor: 1, spinosaurus: 2, megalosaurus: 3, brachiosaurus: 4, stegosaurus: 5, ankylosaurus: 6, triceratops: 7 }

  DIET_BY_SPECIES = {
    'tyrannosaurus' => 'carnivore',
    'velociraptor' => 'carnivore',
    'spinosaurus' => 'carnivore',
    'megalosaurus' => 'carnivore',
    'brachiosaurus' => 'herbivore',
    'stegosaurus' => 'herbivore',
    'ankylosaurus' => 'herbivore',
    'triceratops' => 'herbivore'
  }
  
  before_validation :set_diet

  private

  def set_diet
    self.diet = DIET_BY_SPECIES[species]
  end

  def carnivore_only_with_same_species
    if cage.dinosaurs.where.not(diet: self.diet).exists?
      errors.add(:name, "Can't contain herbivores and carnivores in a single cage")
    elsif !cage.dinosaurs.where(species: species, diet: 'carnivore').exists?
      errors.add(:name, "Can't contain carnivores of different species")
    end
  end

  def dinosaurs_count_within_max_capacity
    if cage && cage.dinosaurs_count >= cage.max_capacity
      errors.add(:dinosaurs_count, "Exceeds maximum capacity of the cage")
    end
  end

  def power_status_check
    if cage.down?
      errors.add(:dinosaurs_count, "Can't add into a cage with power status Down")
    end
  end
end
