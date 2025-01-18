module Repositories
  class ViewRepo
    def create(attrs:)
      View.create!(attrs)
    end

    def exists?(tweet:, user:)
      View.exists?(tweet:, user:)
    end
  end
end
