class MailReceiver < ActionMailer::Base
  def receive(mail)
    # creating the loop first, so that we can save it without a user later on
    return if !mail.multipart?
    html_part = mail.parts.select{|part| part.content_type == 'text/html'}.try(:first)
    return if !html_part
    doc = Hpricot(html_part.body)
    return if doc.nil?
    link = doc.at("a")
    return if link.nil?
    link_contents = link.inner_html
    name_match = link_contents.match(/^nanoloop: (.*?\.nan)$/)
    return if name_match.nil?

    name = name_match[1]
    data = link['href']
    loopie = Loop.new(:name => File.basename(name,'.nan'), :data => data, :message_id => mail.message_id, :public => false)

    receiver = mail.header_string("Delivered-To")
    #loopstore+1Pu051i9j0@googlemail.com
    parts = receiver.match(/^loopstore\+([a-f0-9]{24})([Pp])([a-zA-Z0-9]{8})\@googlemail\.com$/)
    if parts
      user = User.find_by_id(parts[1])
      logger.debug(user)
      is_private = parts[2] == 'P'
      drop = parts[3]
      if user && (user.send("mail_drop_#{is_private ? 'private' : 'public'}".to_sym) == drop)
        loopie.user = user
        loopie.public = !is_private
      end
    end
    loopie.save
    loopie
  end
end
