module  MarkdownHelper

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(renderer_extensions)
    markdown_to_html = Redcarpet::Markdown.new(renderer, extensions)
    markdown_to_html.render(text).html_safe
  end

  private

  def renderer_extensions
    {
      prettify:            true,
      filter_html:         true,
      hard_wrap:           true,
      link_attributes:     { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks:  true
    }
  end

  def extensions
    {
      safe_links_only:      true,
      no_intra_emphasis:    true,
      fenced_code_blocks:   true,
      strikethrough:        true,
      lax_html_blocks:      true,
      autolink:             true,
      superscript:          true,
      disable_indented_code_blocks: true
    }
  end
end
