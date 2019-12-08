class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :expire_comming, -> {where('deadline < ?', Time.zone.today + 7).where.not(status: 2)}
end
