module ApplicationHelper
  def default_url(size)
    "http://placehold.it/"+Latted::Application::ITEM_IMAGE_SIZES[size.to_sym]
  end

end
