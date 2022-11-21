class Post < ActiveRecord::Base
    # extend FriendlyId
    # friendly_id :community_id, use: :slugged
    belongs_to :account
    belongs_to :community
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy
    validates_presence_of :title, :body, :account_id, :community_id

    def score
    # difference between upvotes and downvotes
        if self.upvotes > 0 || self.downvotes > 0
            self.upvotes > 0 ? (self.upvotes - self.downvotes) : (self.downvotes * -1)
        else
            0
        end
    end

    def percentage_upvoted
        if self.upvotes > 0 || self.downvotes > 0  
            ((self.upvotes.to_f)/(self.upvotes.to_f + self.downvotes.to_f))*100
        elsif self.upvotes == 0 && self.downvotes == 0
            0.0
        end
    end

end