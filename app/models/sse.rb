class SSE
  def initialize(io)
    @io = io
  end

  def write(message, options = {})
    options.each do |k, v|
      @io.write("#{k}: #{v}\n")
    end
    @io.write("data: #{message}\n\n")
  end

  def close
    @io.close
  end
end
