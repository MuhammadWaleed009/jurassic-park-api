class CagePolicy < ApplicationPolicy
  def initialize(user, cage)
    super(user, cage)
    @cage = cage
  end

  def show?
    true
  end

  def create?
    user.builder?
  end

  def update?
    user.doctor? || user.scientist?
  end

  def destroy?
    user.builder? && @cage.dinosaurs.empty?
  end
end
