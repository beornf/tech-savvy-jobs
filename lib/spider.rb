require 'digest/sha1'

module Spider
  def self.digest(string)
    Digest::SHA1.hexdigest(string)[0..17]
  end

  def self.visit(pages)
  end

  def host
    self.url
  end
end
