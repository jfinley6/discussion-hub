class Subscription < ApplicationRecord
    belongs_to :account
    belongs_to :community 

    validates_uniqueness_of :account_id, scope: :community_id
end