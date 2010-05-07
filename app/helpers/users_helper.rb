module UsersHelper

  def display_name_for(user)
    h(user.nickname || user.name || user.email || "[has no name]")
  end

  def link_to_user(user)
    link_to display_name_for(user), user_path(user)
  end

  def gravatar_for_user(user, options = {})
    link_to(image_tag(gravatar_url_for(user.email, options)), user_path(user))
  end

  def gravatar_url_for(email = "", options = {})
    email = "" if email.nil?
    url_for({ :gravatar_id => Digest::MD5.hexdigest(email),
      :host => 'www.gravatar.com',
      :protocol => 'http://',
      :only_path => false,
      :controller => 'avatar.php'}.merge(options))
  end


end
