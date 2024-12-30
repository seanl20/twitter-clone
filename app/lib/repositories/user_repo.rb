module Repositories
  class UserRepo
    def get(id:)
      User.find(id)
    end

    def update(id:, attrs:)
      User
        .find(id)
        .update!(attrs)
    end
  end
end
