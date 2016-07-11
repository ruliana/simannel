# frozen_string_literal: true

class Talk
  attr_reader :time_in_minutes

  def initialize(name, time_description)
    @name = name
    @time_in_minutes = translate(time_description)
  end

  def pretty_print(io, nesting = 0)
    io.printf "%s%0.2dmin %s\n", "\t" * nesting, @time_in_minutes, @name
  end

  private
  def translate(time_description)
    case time_description.to_s.strip
    when /^lightning$/i
      5
    when /^(\d+)\s*min$/i
      $1.to_i
    else
      fail "Can't translate #{time_description}"
    end
  end
end
