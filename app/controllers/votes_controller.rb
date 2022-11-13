class SubscriptionsController < ApplicationController

    def create
        is_upvote = params[:upvote]

        vote = Vote.new( vote_params )
        vote.account_id = current_account.id

        existing_vote = Vote.where(account_id: current_account.id, post_id: params[:vote][:post_id])

        if existing_vote.size > 0

        else

        end

    end

    private

    def vote_params
        params.require(:vote).permit(:upvote ,:post_id)
    end

end