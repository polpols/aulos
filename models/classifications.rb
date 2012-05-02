class Classification < ActiveRecord::Base
  belongs_to :work
  belongs_to :classifier
end