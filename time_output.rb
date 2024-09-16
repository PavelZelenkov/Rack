require_relative 'app'

class TimeOutput

  AVAILABLE_FORMATS = { 'year' => '%Y', 'month' => '%m', 'day' => '%d', 'hour' => '%H', 'minute' => '%m', 'second' => '%S' }.freeze

  def initialize(request)
    @formats = request.params['format']
  end

  def converted_time
    date_time = @formats.split(',').map { |format| AVAILABLE_FORMATS[format] }
    Time.now.strftime(date_time.join('-'))
  end

  def empty_formats?
    @formats.nil?
  end

  def formats_valid?
    sampling_unknown_time_formats.empty?
  end

  def sampling_unknown_time_formats
    @unknown_formats = @formats.split(',') - AVAILABLE_FORMATS.keys
  end

  def unknown_time_formats
    @unknown_formats
  end

end
