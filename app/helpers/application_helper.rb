# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def nanoloop_url(loop)
    "#{loop.data}"
  end

  def gravatar_url_for(email, options = {})
    url_for({ :gravatar_id => Digest::MD5.hexdigest(email),
      :host => 'www.gravatar.com',
      :protocol => 'http://',
      :only_path => false,
      :controller => 'avatar.php'}.merge(options))
  end


end
