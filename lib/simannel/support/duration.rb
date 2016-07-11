class Duration
  def initialize(duration_description)
    @duration_description = duration_description.to_s.strip
  end

  def in_minutes
    case @duration_description
    when /^\d+$/
      @duration_description.to_i
    when /^lightning$/i
      5
    when /^(\d+)\s*min$/i
      $1.to_i
    else
      fail "Can't translate #{@duration_description}"
    end
  end
end
