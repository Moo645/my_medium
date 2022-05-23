class StoriesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_story, only: [:edit, :update, :destroy]

  def index
    @stories = current_user.stories.order(created_at: :desc)
  end

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.new(story_params)
    if @story.save
      @story.publish! if params[:publish]
      if @story.published?
        redirect_to stories_path, notice: '故事已發布!'
      else
        redirect_to edit_story_path(@story), notice: '草稿已儲存!'
      end
    else
      render :new, notice: '發生錯誤!'
    end
  end

  def edit
  end


  def update
    if @story.update(story_params)
      case
        when params[:unpublish]
          @story.unpublish!
          redirect_to stories_path, notice: '故事已下架!'
        when params[:publish]
          @story.publish!
          redirect_to stories_path, notice: '故事已發佈!'
        else
        redirect_to stories_path, notice: '故事已更新!'
      end
    end
  end

  def destroy
    @story.delete!
    @story.destroy
    redirect_to stories_path, notice: '故事刪除成功'
  end

  private
  
  def find_story
    @story = current_user.stories.friendly.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:title, :content)
  end

end
