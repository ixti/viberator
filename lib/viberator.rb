# stdlib
require "pathname"

# internal
require "viberator/version"
require "viberator/database"

class Viberator
  def initialize(path)
    @path     = Pathname.new(path).realpath
    @stickers = Pathname.glob(@path.join "data/stickers/60/**/*.png").freeze
  end

  def databases
    @path.children
      .select { |p| p.directory? && p.join("viber.db").exist? }
      .map { |p| Database.new(self, p) }
  end

  def sticker(id)
    @stickers.find { |p| p.to_s =~ /\/0*#{id}.png$/ }
  end
end
