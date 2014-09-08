# internal
require "viberator/record"

class Viberator
  class Event < Record
    def timestamp
      Time.at @attrs[:TimeStamp]
    end

    def author
      @db.author @attrs[:Number]
    end

    def message?
      !@attrs[:Body].to_s.empty?
    end

    def photo?
      !@attrs[:PayloadPath].to_s.empty?
    end

    def sticker?
      0 < @attrs[:StickerID].to_i
    end

    def text
      return @attrs[:Body]    if message?
      return @attrs[:Subject] if photo?
    end

    def image
      return @db.sticker @attrs[:StickerID] if sticker?
      return payload_path                   if photo?
    end

    def image_thumb
      return thumbnail_path if photo?
    end

    private

    def payload_path
      path = Pathname.new @attrs[:PayloadPath]
      return thumbnail_path unless path.exist?
      path
    end

    def thumbnail_path
      Pathname.new @attrs[:ThumbnailPath]
    end
  end
end
