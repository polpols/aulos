class Classification < ActiveRecord::Base
  belongs_to :part
  belongs_to :classifier
end