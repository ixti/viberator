# internal
require "viberator/record"

class Viberator
  class Author < Record
    def avatar
      return if @attrs[:AvatarPath].to_s.strip.empty?
      Pathname.new @attrs[:AvatarPath]
    end

    def name
      return @attrs[:Number] if @attrs[:ClientName].to_s.strip.empty?
      "#{@attrs[:ClientName].to_s.strip} (#{@attrs[:Number]})"
    end
  end
end
