class CallToAction < Liquid::Tag
  Syntax = /(\S+) (\S+) (\S+) (\S+)/

  def initialize(tagName, markup, tokens)
    super

    if markup =~ Syntax then

      @cta_heading = $1
      @cta_link_name = $2
      @cta_link_url = $3
      @cta_image = $4

    else
      raise "Wrong widget format"
    end
  end

  def render(context)
    "<div class='post-cta'><div class='post-cta-left'><p class='post-cta-heading'> #{@cta_heading} </p><a class='post-cta-link' href='#{@cta_link_url}' traget='_blank'>#{@cta_link_name} </a></div><img class='post-cta-image' src='#{@cta_image}' alt='' /></div>"
  end

  Liquid::Template.register_tag "CTA", self
end
