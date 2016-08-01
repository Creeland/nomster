class Comment < ActiveRecord::Base
  # designates that Comment is tied to user and place. 
  belongs_to :user
  belongs_to :place
end
