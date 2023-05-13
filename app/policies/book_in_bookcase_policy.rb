# frozen_string_literal: true

class BookInBookcasePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user == record.bookcase.user
  end

  def new?
    login? && create?
  end

  def update?
    user == record.bookcase.user
  end

  def edit?
    update?
  end

  def destroy?
    user == record.bookcase.user
  end

  private

  def login?
    !user.nil?
  end
end
