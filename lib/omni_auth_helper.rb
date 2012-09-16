class OmniAuthHelper

  def self.get_avatar_url(auth)
    if auth["provider"] == "twitter"
      auth["info"]["image"]
    elsif auth["provider"] == "github"
      auth["extra"]["raw_info"]["avatar_url"]
    elsif auth["provider"] == "browser_id"
      email = auth["uid"]
      hash = Digest::MD5.hexdigest(email.to_s.downcase)
      "http://gravatar.com/avatar/#{hash}?s=64"
    end
  end

end
