class PublicController < ApplicationController

    def index
        @communities = Community.all.order(id: :desc).limit(5)
        @posts = Post.order(id: :desc).limit(20)
    end

    def profile
        @profile = Account.find_by_username params[:username]
        @posts = @profile.posts.order(id: :desc)
        @subscriptions = Subscription.where(account_id: current_account.id)
    end

end