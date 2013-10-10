require 'digest/sha1'
require 'wombat'

module Spider
  class Crawler
    attr_accessor :proc

    def initialize(spec, url)
      @proc, @url = {}, url
      @spec = spec + "\nbase_url #{ host('base') }
      path #{ host('path') }"
      @wombat = Class.new
      @wombat.send(:include, Wombat::Crawler)
    end

    def host(type)
      uri = URI(@url)
      if type == 'base'
        uri.path = ''; uri.to_s
      else
        uri.path
      end
    end

    def option(val)
      val = val.split(/,\s*/)
      (1..val.size-1).each { |j| val[j] = val[j].to_sym }
      val
    end

    def ready
      @spec.split("\n").each do |line|
        cmd = line.strip.split(/;\s*/)
        if cmd.size > 0
          args = cmd.first.split(/\s+/, 2)
          @wombat.send(args[0], *option(args[1]))
          if cmd.size == 2
            @proc[args[0]] = cmd.last
          end
        end
      end
    end

    def scrape
      ready
      @wombat.new.crawl
    end
  end

  def layout(spec)
    crawler = Crawler.new spec, url
    info = crawler.scrape
    crawler.proc.each do |field, code|
      info[field] = info[field].instance_eval code
    end
    info
  end

  def exists?
    @exists ||= ['200', '301'].include? Net::HTTP.new(uri.host).
      request_head(uri.path).code
  end

  def host
    uri.host
  end

  def uri
    @uri ||= URI(url.downcase)
  end

  def self.digest(string)
    Digest::SHA1.hexdigest(string)[0..17]
  end

  def self.visit(pages, delay=10.0)
    chain = Chain.new delay
    pages.each { |p| chain << p }
    chain
  end

  class Chain
    attr_accessor :enum

    def initialize(delay)
      @delay = delay.to_f
      @enum = []
      @hist = {}
    end

    def now
      Time.now.to_f
    end

    def size
      @enum.inject(:+).size
    end

    def each(&block)
      @enum.each do |group|
        join = now + @delay
        group.each(&block)
        if join > now
          sleep join - now
        end
      end
    end

    def <<(val)
      host = val.host
      pos = if @hist.include? host
        @hist[host] += 1
      else
        @hist[host] = 0
      end
      if pos >= @enum.size
        @enum << [val]
      else
        @enum[pos] << val
      end
    end
  end
end
