module PagesHelper
  def read_more(story)
    link_to "(Read more)", story_page_path(story.user.username, story), class: 'has-text-grey'
  end
end
