module MarkdownHelper
  def markdown_to_html(source)
    Kramdown::Document.new(source, input: 'GFM', syntax_highlighter: 'rouge').to_html
  end
end

