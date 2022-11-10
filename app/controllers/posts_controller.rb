class PostsController < ApplicationController
    before_action :authenticate_account!, except: [ :index, :show ]
    before_action :set_post, only: [:show]
    before_action :auth_subscriber, only: [:new]

    def index
        @posts = Post.all
    end

    def show 
    end

    def new
        @community = Community.find(params[:community_id])
        @post = Post.new
    end

    def create
        @post = Post.new post_params
        @post.account_id = current_account.id
        @post.community_id = params[:community_id]
        @community = Community.find(params[:community_id])
        if @post.save
            redirect_to community_path(@community)
        else
            @community = Community.find(params[:community_id])
            render :new 
        end
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def auth_subscriber
        @community = Community.find(params[:community_id])
        unless Subscription.where(community_id: params[:community_id], account_id: current_account.id).any?
            redirect_to community_path(@community), flash: {danger: "You aren't subscribed to this community"}
        end
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end

end