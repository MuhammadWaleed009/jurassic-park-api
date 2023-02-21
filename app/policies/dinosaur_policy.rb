class DinosaurPolicy < ApplicationPolicy
  def initialize(user, dinosaur)
    super(user, dinosaur)
    @dinosaur = dinosaur
  end

  def show?
    true
  end

  def create?
    user.doctor? || user.scientist?
  end

  def update?
    user.doctor? || user.scientist?
  end

  def destroy?
    user.doctor? || user.scientist?
  end
end
