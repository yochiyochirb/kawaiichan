module MarkdownHelper
  def markdown_to_html(source)
    return '' if source.blank?
    Kramdown::Document.new(source, input: 'GFM', syntax_highlighter: 'rouge').to_html
  end
end

