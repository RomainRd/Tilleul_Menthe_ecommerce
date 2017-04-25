module Spree::BaseHelper
  def logo(image_path = 'spree/frontend/Logo2.png', img_option: {})
    link_to image_tag(image_path, img_option), spree.root_path
  end

  def nav_tree(root_taxon, current_taxon, max_level = 1)
    return '' if max_level < 1 || root_taxon.children.empty?
    content_tag :ul, class: 'taxons-list' do
      taxons = root_taxon.children.map do |taxon|
        css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'current' : nil
        content_tag :li, class: "#{css_class} taxon" do
         link_to(taxon.name, seo_url(taxon)) +
           taxons_tree(taxon, current_taxon, max_level - 1) +
           "|"
        end
      end
      safe_join(taxons, "\n")
    end
  end

  def link_to_cart(text = nil)
    text = text ? h(text) : Spree.t(:cart)
    css_class = nil

    if simple_current_order.nil? || simple_current_order.item_count.zero?
      text = "#{text}: (#{simple_current_order.item_count})  <span class='amount'>#{simple_current_order.display_total.to_html}</span>"
      css_class = 'empty'
    else
      text = "#{text}: (#{simple_current_order.item_count})  <span class='amount'>#{simple_current_order.display_total.to_html}</span>"
      css_class = 'full'
    end

    link_to text.html_safe, spree.cart_path, class: "cart-info #{css_class}"
  end
end
