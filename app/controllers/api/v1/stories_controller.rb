class Api::V1::StoriesController < Api::ApiController
  before_action :find_story

  def clap
    if user_signed_in? 
    @story.increment!(:clap) 

    render json: {status: 'ok', clap: @story.clap}
    else
    render json: {status: 'sign_in_first'}
    end
  end

  def bookmark
    if user_signed_in?
      render json: { status: current_user.bookmark!(@story) }
    else
      render json: { status: 'sign_in_first' }
    end
  end

  private
  def find_story
    @story = Story.friendly.find(params[:id])
  end

end
