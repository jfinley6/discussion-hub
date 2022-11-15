class VotesController < ApplicationController

    def create 
        post_id = params[:post_id]

        vote = Vote.new
        vote.post_id = params[:post_id]
        vote.upvote = params[:upvote]
        vote.account_id = current_account.id
        @user_post = Post.find(params[:post_id]).account

        existing_vote = Vote.where(account_id: @user_post.id, post_id: post_id)
        @new_vote = existing_vote.size < 1

        respond_to do |format|
            format.js {
                if existing_vote.size > 0
                    @previous_vote = existing_vote.first.upvote
                    if existing_vote.first.upvote == vote.upvote
                        existing_vote.first.upvote ? @user_post.increment!(:karma, by = -1) : @user_post.increment!(:karma, by = 1)
                        existing_vote.first.destroy
                    else
                        existing_vote.first.upvote ? @user_post.increment!(:karma, by = -2) : @user_post.increment!(:karma, by = 2)
                        existing_vote.first.destroy
                        if vote.save
                            @success = true
                        else
                            @success = false
                        end
                    end
                else
                    @previous_vote = nil
                    vote.upvote ? @user_post.increment!(:karma, by = 1) : @user_post.increment!(:karma, by = -1)
                    if vote.save
                        @success = true
                    else
                        @success = false
                    end
                end

                @vote = vote.upvote
                @post = Post.find(post_id)
                @is_upvote = params[:upvote]
    
                render "votes/create"
                
            }
        end

       
    end

    private

    def vote_params
        params.require(:vote).permit(:upvote ,:post_id)
    end

end