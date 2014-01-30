require 'date'

module TemporalContent

  ROOTPATH = File.join("source","_temporal")

  def self.get(name, cutoff=Date.today, rootpath=ROOTPATH)
    theme = Theme.new(name, rootpath)
    theme.current_items(cutoff).first
  end

  class Theme
    attr_accessor :items

    def initialize(name, rootpath=ROOTPATH)
      @name = name
      @rootpath = rootpath
      @items = all_items.map { |path| Item.new(path) }
    end

    def current_items(cutoff)
      items.reject { |item| item.expired?(cutoff) }
    end

    private

    def all_items
      # partial files must begin with an underscore
      Dir.glob("#{container}/_*")
    end

    def container
      File.join(@rootpath, @name)
    end

  end

  class Item
    include Comparable
    attr_accessor :path

    def initialize(path)
      @path = path
    end

    def expiry_date
      basename = File.basename(@path)
      if basename.include? "default"
        :never
      else
        Date.parse(basename)
      end
    end

    def current?(cutoff=Date.today)
      (expiry_date == :never || cutoff <= expiry_date)
    end

    def expired?(cutoff=Date.today)
      !current?(cutoff)
    end

    def <=>(other)
      return 1 if expiry_date == :never
      return -1 if other.expiry_date == :never
      expiry_date <=> other.expiry_date
    end

    def partial_path
      dir,base = File.split(path)
      ext = File.extname(base)
      cleanbase = File.basename(base, ext).sub(/^_/, '')
      cleandir  = dir.slice(/_temporal.*$/)
      File.join(cleandir, cleanbase)
    end
  end

end
