# 3rd-party
require "sqlite3"
require "sequel"

# internal
require "viberator/chat"
require "viberator/event"
require "viberator/author"

class Viberator
  class Database
    def initialize(viberator, path)
      @viberator  = viberator
      @path       = Pathname.new path
      @connection = Sequel.connect "sqlite://#{@path.join "viber.db"}"
    end

    def name
      @path.basename.to_s
    end

    def chats
      @connection[:ChatInfo].map { |attrs| Chat.new(self, attrs) }
    end

    def events(chat_id)
      @connection[:EventInfo]
        .where(:ChatID => chat_id)
        .order(:TimeStamp)
        .map { |attrs| Event.new(self, attrs) }
    end

    def author(number)
      attrs = @connection[:OriginNumberInfo].where(:Number => number).first
      Author.new(self, attrs || { :Number => number })
    end

    def sticker(id)
      @viberator.sticker id
    end
  end
end
