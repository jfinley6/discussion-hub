class PublicController < ApplicationController

    def index
        @communities = Community.all.order(id: :desc).limit(5)
        @posts = Post.limit(20).sort_by{ |p| p.score}.reverse
    end

    def profile
        @profile = Account.find_by_username params[:username]
        @posts = @profile.posts.order(id: :desc).limit(10)
        @subscriptions = Subscription.where(account_id: @profile.id)
        @karma = @profile.karma
    end

end