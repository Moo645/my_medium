class Api::V1::StoriesController < Api::ApiController

  def clap
    if user_signed_in? 
    @story = Story.friendly.find(params[:id])
    @story.increment!(:clap) 

    render json: {status: 'ok', clap: @story.clap}
    else
    render json: {status: 'sign_in_first'}
    end
  end

end
