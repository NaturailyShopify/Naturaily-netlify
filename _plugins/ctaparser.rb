class CallToAction < Liquid::Tag
  Syntax = /\(.*?\)\[.*?\]\<.*?\>\|.*?\|/

  def initialize(tagName, markup, tokens)
    super

    if markup =~ Syntax then

      @cta_heading = markup.match(/\((.*?)\)/)[1]
      @cta_link_name = markup.match(/\[(.*?)\]/)[1]
      @cta_link_url = markup.match(/\<(.*?)\>/)[1]
      @cta_image = markup.match(/\|(.*?)\|/)[1]

    else
      raise "Wrong widget format"
    end
  end

  def render(context)
    "<div class='post-cta'><div class='post-cta-left'><p class='post-cta-heading'> #{@cta_heading} </p><a class='post-cta-link' href='#{@cta_link_url}' traget='_blank'>#{@cta_link_name} </a></div><img class='post-cta-image' src='#{@cta_image}' alt='' /></div>"
  end

  Liquid::Template.register_tag "CTA", self
end
