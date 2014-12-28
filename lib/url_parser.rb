# encoding: utf-8
class UrlParser
  LINK_REGEX = /\b((?:https?:\/\/)?(?:[\S]+\.)+(?:[\S]+)([^[:punct:]\s]|\/))/ix

  def self.extract_url(text)
    text.slice(LINK_REGEX)
  end
end
