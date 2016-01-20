require 'base64'
module PrintNode
  # An object for printjob creation.
  # @author Jake Torrance
  # @author PrintNode
  class PrintJob
    attr_accessor :printer_id
    attr_accessor :title
    attr_accessor :content_type
    attr_accessor :content
    attr_accessor :source
    attr_accessor :in_memory
    attr_accessor :use_base64

    # Maps the object into a hash ready for JSON Encoding.
    def to_hash
      hash = {}
      hash['printerId'] = @printer_id
      hash['title'] = @title
      hash['contentType'] = @content_type
      if @use_base64
        if @content_type.include?('base64')
          if @in_memory
            hash ['content'] = Base64.encode64(@content)
          else
            hash ['content'] = Base64.encode64(IO.read(@content))
          end
        else
          hash ['content'] = @content
        end
      else
        hash ['content'] = @content
      end  
      hash['source'] = @source
      hash
    end

    # Initializes the object with the variables required.
    def initialize(printer_id, title, content_type, content, source, in_memory, use_base64)
      @printer_id = printer_id
      @title = title
      @content_type = content_type
      @content = content
      @source = source
      @in_memory = in_memory
      @use_base64 = use_base64
    end
  end
end
