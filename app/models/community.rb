class Community < ActiveRecord::Base
   extend FriendlyId
   friendly_id :url, use: [:slugged, :finders]  
   belongs_to :account
   validates_presence_of :url, :rules, :summary
   validates :url, uniqueness: true
   has_many :posts, dependent: :destroy
   has_many :subscriptions, dependent: :destroy 
   has_many :subscribers, through: :subscriptions, source: :account
end