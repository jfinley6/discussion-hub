class Community < ActiveRecord::Base
   # extend FriendlyId
   # friendly_id :url, use: [:slugged, :finders] 
   belongs_to :account
   has_many :posts
   validates_presence_of :url, :name, :rules
end