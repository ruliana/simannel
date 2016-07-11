# frozen_string_literal: true

class Talk
  def initialize(name, duration_description)
    @name = name
    @duration = Duration.new(duration_description)
  end

  def time_in_minutes
    @duration.in_minutes
  end

  def pretty_print(io, nesting = 0)
    io.printf "%s%0.2dmin %s\n", "\t" * nesting, @duration.in_minutes, @name
  end
end
