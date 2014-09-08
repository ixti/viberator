# internal
require "viberator/record"

class Viberator
  class Chat < Record
    def name
      return @attrs[:Name] if @attrs[:Name] == @attrs[:Token]
      "#{@attrs[:Name]} (#{@attrs[:Token]})"
    end

    def events
      @db.events @attrs[:ChatID]
    end
  end
end
