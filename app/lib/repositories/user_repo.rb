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

    def get_by_username(username:)
      User.find_by(username:)
    end
  end
end
