require_relative 'time_output'
require_relative 'time_formatter'

class App

  def call(env)
    request = Rack::Request.new(env)
    @output = TimeOutput.new(request)
    @time_formatter = TimeFormatter.new(request.path)
    check_request
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def check_request
    if @time_formatter.invalid_path?
      make_response(404, "Error: Invalid URL\n")
    elsif @output.empty_formats?
      make_response(400, "Error: Time formats missing\n")
    else
      convert_time
    end
  end
  
  def convert_time
    if @output.formats_valid?
      make_response(200, @output.converted_time)
    else
      make_response(400, "Error: Unknown format(s) #{@output.unknown_time_formats} Allowed time formats: #{TimeOutput::AVAILABLE_FORMATS.keys}")
    end
  end

  def make_response(status, body)
    response = Rack::Response.new([body], status, {})
    response.finish
  end

end
