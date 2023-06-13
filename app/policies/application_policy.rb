# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def dashboard?
    return false unless user

    user.is_admin?
  end

  def export?
    dashboard?
  end

  def show_in_app?
    dashboard?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise Pundit::NotAuthorizedError, 'must be logged in' unless user

      return unless user.is_admin?

      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
