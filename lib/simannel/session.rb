class Session
  def initialize(name, time_limit, talks = [])
    @name = name
    @talks = talks
    @time_limit = if time_limit.is_a? Range
                    time_limit
                  else
                    time_limit..time_limit
                  end
  end

  def add(talk)
    Session.new(@name, @time_limit, @talks + [talk])
  end

  def remove_random_talk
    talk, *rest = @talks.shuffle
    [talk, Session.new(@name, @time_limit, rest)]
  end

  def empty?
    @talks.empty?
  end

  def time_total
    @time_total ||= @talks.map(&:time_in_minutes).reduce(0, &:+)
  end

  def time_violated
    if time_total < @time_limit.min
      @time_limit.min - time_total
    elsif time_total > @time_limit.max
      time_total - @time_limit.max
    else
      0
    end
  end

  def pretty_print(io, nesting = 0)
    io.printf "%s(%d/%d..%d) %s\n",
      "\t" * nesting,
      @time_total,
      @time_limit.min,
      @time_limit.max,
      @name

    @talks.each { |t| t.pretty_print(io, nesting + 1) }
  end
end
