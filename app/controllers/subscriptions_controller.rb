class SubscriptionsController < ApplicationController

    def index

    end

    def create
        @subscription = Subscription.new(subscription_params)
        @subscription.account_id = current_account.id
        @subscription.save
        redirect_to community_path(@subscription.community)
    end

    def destroy
        @community = Community.find(params[:community_id])
        @subscription = Subscription.find_by(community_id: params[:community_id], account_id: current_account.id)
        @subscription.destroy
        redirect_to community_path(@community)
    end

    private

    def subscription_params
        params.require(:subscription).permit(:community_id)
    end
end