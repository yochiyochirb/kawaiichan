module EmojiHelper
  def emojify(content)
    return "" if content.blank?
    content.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias(Regexp.last_match[1])
        %(<img alt="#{Regexp.last_match[1]}" ) \
          + %(src="#{image_path("emoji/#{emoji.image_filename}")}" ) \
          + %(style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end.html_safe
  end
end
