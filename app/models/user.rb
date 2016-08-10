class User < ActiveRecord::Base
  has_many :foods
  has_many :waste_counts
  has_secure_password
  validates :fname, presence: true, length: { maximum: 25 }
  validates :lname, presence: true, length: { maximum: 25 }
  validates :emp_no, presence: true, length: { maximum: 3 }, 
            numericality: { only_integer: true }
  validates :store_number, presence: true, length: { minimum: 3, maximum: 5 },
            numericality: { only_integer: true }
  validates :password, presence: true, length: {maximum: 4 },
            numericality: { only_integer: true }
end
