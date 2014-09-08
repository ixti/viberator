# stdlib
require "pathname"
require "fileutils"
require "digest/md5"

# 3rd-party
require "slim"

class Viberator
  class Writer
    TEMPLATE = Slim::Template.new "#{__dir__}/template.slim"

    attr_reader :chat

    def initialize(chat)
      @chat = chat
    end

    def write(output)
      @output    = Pathname.new output
      @assets    = @output.join "assets"
      @processed = {}

      fail "Output path already exists! Halt!" if @output.exist?

      @output.mkdir
      @assets.mkdir

      @output.join("index.html").open "w" do |io|
        io << TEMPLATE.render(self)
      end
    end

    private

    %i[javascript stylesheet].each do |type|
      assets_path = Pathname.new(__dir__).join("assets").realpath.to_s
      class_eval <<-RUBY, __FILE__, __LINE__
        def #{type}(file)
          asset Pathname.new(#{assets_path.inspect}).join file
        end
      RUBY
    end

    def asset(file)
      return unless file

      src = Pathname.new file
      uid = Digest::MD5.hexdigest src.to_s
      dst = @assets.join "#{uid}#{src.extname}"

      unless @processed[uid]
        FileUtils.cp src, dst
        @processed[uid] = true
      end

      dst.relative_path_from @output
    end
  end
end
