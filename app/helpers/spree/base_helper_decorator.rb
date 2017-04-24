module Spree::BaseHelper
  def logo(image_path = 'spree/frontend/logo.svg', img_option: {})
    link_to image_tag(image_path, img_option), spree.root_path
  end
end
