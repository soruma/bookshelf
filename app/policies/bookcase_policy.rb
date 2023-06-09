# frozen_string_literal: true

class BookcasePolicy < ApplicationPolicy
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

  def create?
    return true if login? && user.is_admin?

    user == record.user
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def edit?
    update?
  end

  def destroy?
    create?
  end

  private

  def login?
    !user.nil?
  end
end
