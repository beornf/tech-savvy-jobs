module ApplicationHelper
  def method_missing(method, *args, &block)
    value = Settings.get(method.to_s)
    if value.present?
      value
    else
      super
    end
  end

  def page_links(pages, menu=true)
    capture_haml do
      head = true
      pages.each do |name, text|
        name = name.to_s
        path = if name == 'root'
          root_path
        else
          page_path(name)
        end
        if menu
          haml_tag :li, :class => (path == request.fullpath ?
            'selected' : '') do
            haml_concat link_to text, path
          end
        else
          if not head
            haml_concat '&#183;'.html_safe
          else
            head = false
          end
          haml_concat link_to text, path
        end
      end
    end
  end

  def page_title(page_name)
    if page_name.empty?
      "#{title} &#8211; #{description}"
    else
      "#{page_name} &#8211; #{title}"
    end.html_safe
  end

  def short_title(title)
    title.split(/\s*[-@()]/).first
  end

  def summary(text)
    line = ''
    doc = Nokogiri::HTML::DocumentFragment.parse(text)
    doc.enum_for(:traverse).each do |cur|
      if cur.text?
        line = cur.text
        if line.count('.') > 1 and line.split.count > 5
          break
        end
      end
    end
    line
  end
end
