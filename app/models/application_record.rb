class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  PER_PAGE = 10
end
