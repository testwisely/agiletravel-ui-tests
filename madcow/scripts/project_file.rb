#require 'ruby_parser'
require 'digest/md5'

module TestWise
  class ProjectFile

    attr_reader :file_path
    attr_reader :lines

    attr_accessor :initial_checksum # the file's hash when project opens

    def initialize(file, content = nil)
      @file_path = file
      refresh(content)
    end

    def checksum()
      Digest::MD5.hexdigest(@content)
    end

    def refresh(content = nil)
      if content
        @content = content
      else
        @content = File.read(@file_path)
      end
      @lines = []
      @content.each_line { |line|
        line.chomp!
        @lines << line
      }
      refresh_self()
    end

    def refresh_self
      # do nothing for normal file
    end

    def save_back
      open(@file_path, "w") { |f|
        f.puts lines.join("\n")
        f.flush
      }
    end


    def ident(code, identation)
      if code.class == Array
        idented_code = code.map { |line| identation+line }.join("\n")
      else
        idented_code = code.split("\n").map { |line| identation+line }.join("\n")
      end
      idented_code += "\n" if code[-1] == "\n"[0]
      idented_code
    end

    def extract_identation_level_from(line)
      spaces = line.match(/^(\s*)\w/)
      spaces.captures[0]
    end

  end # end of class

end
