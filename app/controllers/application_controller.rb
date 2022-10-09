class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed


  private

  def not_destroyed(err)
    render json: { errors: err.record.errors }, status: :unprocessable_entity
  end
end
