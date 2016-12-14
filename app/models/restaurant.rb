class Restaurant < ActiveRecord::Base
  has_one :gm, class_name: 'User', foreign_key: 'gm'
  has_many :users
  has_many :responses
  has_many :waste_counts
  has_many :surveys

  validates :store, uniqueness: true
end
