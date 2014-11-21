class Planning < ActiveRecord::Base
  belongs_to :account
  has_many :buffered_weeks, dependent: :destroy
end
