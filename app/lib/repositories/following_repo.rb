module Repositories
  class FollowingRepo
    def get(id:)
      Following.find(id)
    end

    def create(attrs:)
      Following.create!(attrs)
    end

    def delete(id:)
      Following
        .find(id)
        .destroy
    end
  end
end
