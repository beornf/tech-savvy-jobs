class String
  def hyperlink(index=0)
    fragment = Nokogiri::HTML::DocumentFragment.parse(self)
    link = fragment.css('a')
    if index < link.size
      href = link[index]['href']
      href + (href.count('/') == 2 ? '/' : '')
    end
  end
end

class NilClass
  def hyperlink
    nil
  end
end