module HomeHelper
  def refine_links
    max = 5
    capture_haml do
      Settings.refine.each do |name, links|
        haml_tag :h3, name.titlecase
        haml_tag :ul do
          links.each_with_index do |args, index|
            key, text = args
            haml_tag :li, :class => (index >= max ?
              'hidden' : '') do
              haml_concat link_to text, key
            end
          end
        end
        if links.count > max
          haml_tag :div, :class => 'show' do
            haml_tag :span, 'more..'
          end
        end
      end
    end
  end
end