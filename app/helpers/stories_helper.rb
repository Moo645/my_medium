module StoriesHelper

  def cover_image(story, size: [150, 150])
    image_tag story.cover_image.variant(resize_to_fit: size), class: 'cover_image' if story.cover_image.attached?
  end

end
