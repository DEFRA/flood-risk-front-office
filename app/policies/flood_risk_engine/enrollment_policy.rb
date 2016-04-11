module FloodRiskEngine
  class EnrollmentPolicy

    CRUD_ACTIONS = %i[new create edit update destroy show index].freeze

    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def index?
      false
    end

    def create?
      true
    end

    def show?
      true
    end

    def update?
      not record.submitted?
    end

    def edit?
      update?
    end

    def show_continue_button?
      not record.submitted?
    end

    def destroy?
      false
    end

    def scope
      Pundit.policy_scope! user, record.class
    end

    class Scope
      attr_reader :user, :scope

      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        if user.try! :has_any_role?
          scope.all
        else
          scope.none
        end
      end
    end

  end
end

class DigitalServicesCore::EnrollmentPolicy < FloodRiskEngine::EnrollmentPolicy
end

