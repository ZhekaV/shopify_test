class Collection < ApplicationRecord
  extend Enumerize

  belongs_to :shop

  enumerize :kind, in: %i[smart custom]
end
