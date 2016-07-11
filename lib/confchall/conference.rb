class Conference
  def initialize(sessions)
    @sessions = sessions
  end

  def organize
    solver = SimulatedAnnealing.new
    solver.call(self)
  end

  def time_violated
    @time_violated ||= sum_from_sessions(&:time_violated)
  end

  def time_total
    @time_total ||= sum_from_sessions(&:time_total)
  end

  def random_move
    # Here be dragons! At least one session
    # must be not empty otherwise the loop
    # never ends =/
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

  # Simulated Annealing protocol
  alias :random_neighbor :random_move
  alias :energy :time_violated

  private

  def sum_from_sessions(&attribute_block)
    @sessions.map(&attribute_block).reduce(0, &:+)
  end
end
