module AutoLinkHelper
  def auto_link(source)
    Rinku.auto_link(source, :urls, nil, nil)
  end
end
