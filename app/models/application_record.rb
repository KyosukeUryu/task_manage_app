class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :expire_comming, -> {where('deadline < ?', Time.zone.today + 10)}
end
