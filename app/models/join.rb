# frozen_string_literal: true
class Join < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
