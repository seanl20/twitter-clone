# frozen_string_literal: true

module Users
  module Commands
    class Update < Command
      def call(id:, params:)
        yield update_user(id:, attrs: Users::Changesets::Update.map(params))

        Success(:success)
      end

      def update_user(id:, attrs:)
        Success(Repositories::UserRepo.new.update(id:, attrs:))
      rescue ActiveRecord::RecordInvalid
        Failure(:invalid)
      rescue ActiveRecord::RecordNotFound
        Failure(:not_found)
      end
    end
  end
end
