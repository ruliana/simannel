class Conference
  def initialize(sessions)
    @sessions = sessions
  end

  def organize
    solver = SimulatedAnneling.new
    solver.call(self)
  end

  def time_violated
    @sessions.map(&:time_violated).reduce(0, &:+)
  end

  def time_total
    @sessions.map(&:time_total).reduce(0, &:+)
  end

  def random_move
    begin
      a, b, *rest = @sessions.shuffle
    end while a.empty?
    talk, a_session = a.remove_random_talk
    b_session = b.add(talk)
    Conference.new([a_session, b_session, *rest])
  end

  def pretty_print(io)
    @sessions.each { |s| s.pretty_print(io) }
  end

  # Simulated Anneling protocol
  alias :random_neighbor :random_move

  def energy
    @energy ||= time_violated / time_total.to_f
  end
end
