class Restaurant < ActiveRecord::Base
  has_one :gm, class_name: 'User', foreign_key: 'gm'
  has_many :users

  validates :store, uniqueness: true
end
