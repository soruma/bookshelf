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
    user == record.user
  end

  def new?
    login? && create?
  end

  def update?
    user == record.user
  end

  def edit?
    update?
  end

  def destroy?
    user == record.user
  end

  private

  def login?
    !user.nil?
  end
end
