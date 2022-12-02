class PostsController < ApplicationController
    before_action :authenticate_account!, except: [ :index, :show ]
    before_action :set_post, only: [:show]
    before_action :auth_subscriber, only: [:new]
    helper_method :params
    before_action :check_params, only: [:index]

    def index

        


        
        cookies[:moon] ||= "dark mode off"
        
        if account_signed_in?
            
        elsif params[:sort] === "front_page"
            params[:sort] = "top"
        end

        subscriptions = Subscription.where(account_id: current_account)
        front_page_posts = Array.new
        subscriptions.each { |subscription|
            if Community.find(subscription.community_id).posts === []

            else
                front_page_posts.push(Community.find(subscription.community_id).posts)
            end
        }

        if params[:sort] === "new"
            # time parameter will eventually be used to sort by time rather than order
            @posts = Post.order("#{params[:time]} DESC").limit(20)
        elsif params[:sort] === "front_page"
            front_page_posts = front_page_posts.flatten
            @posts = front_page_posts.sort_by{|obj| -obj.upvotes}
        elsif params[:sort] === "top"
            @posts = Post.all.order("upvotes DESC")
        end

        @sort = params[:sort]
        @url = request.original_url
        @communities = Community.all.order(id: :desc).limit(5)
    end

    def show 
        @comment = Comment.new
        @subscription = Subscription.new
        @is_subscribed = account_signed_in? ? Subscription.where(community_id: @post.community.id, account_id: current_account.id).any? : false
        @subscribers_count = @post.community.subscribers.count
    end

    def new
        @community = Community.find(params[:community_id])
        @post = Post.new
    end

    def create
        @post = Post.new post_params
        @post.account_id = current_account.id
        @post.community_id = Community.find_by(slug: params[:community_id]).id
        @post.slug = @post.title.downcase.tr_s(' ', '_').gsub("?", "").gsub("'", "").gsub("!", "") + "_" + SecureRandom.hex(4)
        @community = Community.find_by(slug: params[:community_id])
        if @post.save
            @vote = Vote.new
            @vote.account_id = current_account.id
            @vote.post_id = @post.id
            @vote.upvote = true
            @vote.save
            @vote.account.increment!(:karma, 1)
            redirect_to community_path(@community)
        else
            @community = Community.find_by(slug: params[:community_id])
            render :new 
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        if @post.destroyed?
            respond_to do |format|
                format.js {
                    render "posts/delete"
                }
            end
        end

    end

    private

    def set_post
        @post = Post.includes(:comments).friendly.find(params[:id])
    end

    def auth_subscriber
        @community = Community.find_by(slug: params[:community_id])
        unless Subscription.where(community_id: @community.id, account_id: current_account.id).any?
            redirect_to community_path(@community), flash: {danger: "You aren't subscribed to this community"}
        end
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def check_params
        if ['front_page', "top", "new"].include? params[:sort]

        else
            redirect_to root_path
        end
    end

    

end