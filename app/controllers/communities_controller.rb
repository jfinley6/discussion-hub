class CommunitiesController < ApplicationController
    before_action :authenticate_account!, except: [ :index, :show ]
    before_action :set_community, only: [:show]

    def index
        @communities = Community.all
        @communities_count = Community.all.count
        @subscriptions = account_signed_in? ? Subscription.where(account_id: current_account.id) : nil
    end

    def show 
        @posts = @community.posts.order(id: :desc)
        @subscribers_count = @community.subscribers.count
        @is_subscribed = account_signed_in? ? Subscription.where(community_id: @community.id, account_id: current_account.id).any? : false
        @subscription = Subscription.new
    end

    def new
        @community = Community.new
    end

    def create
        @community = Community.new community_params
        @community.account_id = current_account.id
        @community.slug = @community.url

        if @community.save
            redirect_to communities_path
        else
            render :new 
        end
    end

    private

    def set_community
        @community = Community.find(params[:id])
    end

    def community_params
        params.require(:community).permit(:name, :url, :summary, :rules)
    end

end