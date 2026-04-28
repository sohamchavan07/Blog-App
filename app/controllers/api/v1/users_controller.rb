module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = Rails.cache.fetch("users", expires_in: 10.minutes) do
          User.order(:id).to_a
        end

        render json: users
      end
    end
  end
end
