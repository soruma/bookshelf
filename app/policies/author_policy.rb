# frozen_string_literal: true

class AuthorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    true if login? && user.is_admin?
  end

  def edit?
    update?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  private

  def login?
    !user.nil?
  end
end
