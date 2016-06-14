module AutoLinkHelper
  def auto_link(source)
    Rinku.auto_link(source, mode=:urls, link_attr=nil, skip_tags=nil)
  end
end
