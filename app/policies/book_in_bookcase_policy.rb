# frozen_string_literal: true

class BookInBookcasePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    return true if login? && user.is_admin?

    user == record.bookcase.user
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
