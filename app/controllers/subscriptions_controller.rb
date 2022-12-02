class SubscriptionsController < ApplicationController

    def index

    end

    def create
        if (account_signed_in?)
            @subscription = Subscription.new(subscription_params)
            @subscription.account_id = current_account.id
            @subscription.save
            redirect_back(fallback_location: root_path)
        else
            redirect_to new_account_registration_path
        end
    end

    def destroy
        @community = Community.find(params[:community_id])
        @subscription = Subscription.find_by(community_id: params[:community_id], account_id: current_account.id)
        @subscription.destroy
        redirect_back(fallback_location: root_path)
    end

    private

    def subscription_params
        params.permit(:community_id)
    end
end