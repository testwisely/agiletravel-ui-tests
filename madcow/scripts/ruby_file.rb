require 'sexp_processor'

module TestWise

  class LineFinder
    def initialize(ast)
      @ast = ast
      @processor = MethodLineFinderProcessor.new
      @processor.process(@ast)
    end

    def method_ranges
      @processor.methods
    end

    def class_names
      @processor.class_names
    end

  end


  class MethodLineFinderProcessor < ::SexpProcessor
    attr_reader :class_names
    attr_reader :methods

    def initialize
      super()
      self.strict = false
      self.require_empty = false
      @methods = []
      @class_names = []
    end

    def process_defn(exp)
      start_line = exp.line
      method_name = exp.shift
      method_name = exp.shift.to_s if method_name.to_s == "defn"

      last_exp = exp
      while !exp.empty?
        last_exp = exp.shift
      end
      end_line = last_exp.line
      @methods << {method_name => Range.new(start_line, end_line)}
      exp
    end

    def process_class(exp)
      a = exp.shift
      @class_names << exp[0].to_s
      process(exp)
    end
  end


  class RubyFile < ProjectFile

    $LOOKUP_WIDTH = RUBY_PLATFORM.include?("darwin") ? 70 : 72

    attr_reader :method_lookups
    attr_reader :method_file_lookups

    attr_reader :class_names

    attr_reader :sexp

    attr_reader :parent_class
    attr_reader :class_declaration_line_number

    attr_reader :method_ranges

    def RubyFile.func_key(method_name, file_name)
      return nil if method_name.nil? or file_name.nil?
      file_name.gsub!(".rb", "")
      begin
        method_name.strip + " " * ($LOOKUP_WIDTH - 3 - file_name.strip.length - method_name.strip.length) + " - " + file_name.strip
      rescue => e
        method_name.strip + " - " + file_name.strip
      end
    end

    def contains_method?(method_name)
      return false if method_name.nil?
      @method_lookups.keys.include?(method_name)
    end
		
		# if the file is openeed in edtior
		# force no refresh
		def refresh_in_editor
			the_file_editor = EditorSession.get(self.file_path)
			if the_file_editor 
				the_file_editor.reload
			end
		end
		
    # insert new code after last method
    #
    def insert_after_last_method(new_lines, save_back = true)
	    self.refresh_self
      if new_lines
        new_lines = [new_lines] if new_lines.class == String		
				if @method_ranges.any? 
	        last_method_end_line = @method_ranges.last.values[0].end
	        last_method_start_line = @method_ranges.last.values[0].begin
		  	else
					lines_before_last_end = 0
					@lines.reverse.each do |line|
						lines_before_last_end += 1 
						next if line.nil? || line.empty?
						if line =~ /^\s*end\s*/
							lines_before_last_end += 1 
							break
						else
							break
						end
					end
					
					last_method_start_line = last_method_end_line = @lines.size - lines_before_last_end + 1
				end			
        using_extracted_indentation = false
        if using_extracted_indentation
          method_identation_str = extract_identation_level_from(@lines[last_method_start_line - 1]) rescue ""        
        else
          method_identation_str = ""
        end
        # puts "[DEBUG] last method line => #{last_method_end_line} | #{method_identation_str}"
        @lines.insert(last_method_end_line, ident(new_lines, method_identation_str).split("\n"))
        @lines.flatten!
        self.save_back if save_back
				refresh_self
      end
    end

		# only when @lines is empty
    def refresh_self
			@content = @lines.join("\n") unless @lines.empty?
      refresh_by_sexp
    end

		# parse lines
		def refresh_content
			self.refresh File.read(@file_path)
		end
		
    def refresh_by_sexp
      start_time = Time.now
      require 'ruby_parser'

      @method_ranges = []
      @class_names = []
      @method_lookups = {}
      @method_file_lookups = {}
      return if @content.nil? || @content.strip.empty?
      begin
        @sexp = ::RubyParser.new.parse(@content)
        line_finder = LineFinder.new(@sexp.clone)
        @method_ranges = line_finder.method_ranges
        @class_names = line_finder.class_names
        @method_lookups = @method_ranges.inject { |all, h| all.merge(h) }
      rescue SyntaxError => se
        puts "Error parse #{self.file_path} using ruby parser: #{se}"
      rescue => e
        puts "Failed to parse #{self.file_path} | #{@content.size} using ruby parser: #{e.backtrace}"
      end
      @method_ranges.each do |a_hash|
        @method_file_lookups[RubyFile.func_key(a_hash.keys[0], File.basename(@file_path))] = a_hash.values[0].begin
      end
    end


    def method_names(including_parent = false)
      defined_method_names = @method_lookups.keys
      if (including_parent) then
        parent_ruby_file = $itest2_controller.project.page_class_to_ruby_file_lookups[@parent_class]
        if parent_ruby_file
          #TODO: not geting parent's method names
          # puts "debug: #{parent_ruby_file.class_names}"
          defined_method_names << parent_ruby_file.method_names
        end
      end
      #puts "debug: #{defined_method_names.flatten}"
      all_methods = defined_method_names.flatten
      all_methods.delete("initialize")
      return all_methods
    end

    def get_method_last_line(method_name)
      range = @method_lookups[method_name]
      if range
        return range.end
      else
        nil
      end
    end

    def get_scope_for_line(line_no)
      @method_ranges.each do |x|
        range = x.values[0]
        return range if range.include?(line_no)
      end
      return Range.new(1, @lines.size)
    end

  end # end of class
end