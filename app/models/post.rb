class Post < ActiveRecord::Base
    # extend FriendlyId
    # friendly_id :url, use: :slugged
    belongs_to :account
    belongs_to :community
    validates_presence_of :title, :body, :account_id, :community_id
end