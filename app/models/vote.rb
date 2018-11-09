class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :voters, polymorphic: true

  validates :user_id, :presence => true
end
