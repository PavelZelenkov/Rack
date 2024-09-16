require_relative 'app'

class TimeFormatter

  def initialize(path)
    @path = path
  end

  def invalid_path?
    @path != '/time'
  end
  
end
