# frozen_string_literal: true

module Users
  module Commands
    class Update < Command
      def call(id:, params:)
        return Failure(:empty_username) unless params[:username].present?

        yield update_user(id:, attrs: Users::Changesets::Update.map(params))

        Success(:success)
      end

      def update_user(id:, attrs:)
        Success(Repositories::UserRepo.new.update(id:, attrs:))
      rescue ActiveRecord::RecordInvalid => errors
        Failure(invalid: errors.message)
      rescue ActiveRecord::RecordNotFound
        Failure(:not_found)
      end
    end
  end
end
