# stdlib
require "forwardable"

# 3rd-party
require "highline"

# internal
require "viberator"
require "viberator/writer"

class Viberator
  class CLI
    extend Forwardable

    def initialize
      @term = HighLine.new
    end

    def run
      Writer.new(chat database viberator).write output
    end

    private

    def_delegators :@term, :ask, :choose

    def viberator
      path = ask "Viber path? " do |q|
        q.default = "#{ENV["HOME"]}/.ViberPC"
      end

      Viberator.new path
    end

    def database(viberator)
      choose do |menu|
        menu.prompt = "Viber profile? "

        viberator.databases.each do |db|
          menu.choice(db.name) { db }
        end
      end
    end

    def chat(database)
      choose do |menu|
        menu.prompt = "Viber chat? "

        database.chats.each do |chat|
          menu.choice(chat.name) { chat }
        end
      end
    end

    def output
      ask "Output path? " do |q|
        q.default = "viberator"
      end
    end
  end
end
