class SimulatedAnneling
  def initialize
    @max_iterations = 1000
    @max_retries = 5
  end

  def call(state)
    best = state

    @max_retries.times do
      current = best

      @max_iterations.times do |iteration|
        return current if current.energy <= 0

        new = current.random_neighbor

        best = new if new.energy < best.energy
        current = new if transition_probability(current, new, iteration) > rand
      end
    end

    best
  end

  def transition_probability(old, new, iteration)
    return 1 if new.energy < old.energy
    temperature = 1 - iteration / @max_iterations.to_f
    Math.exp(-(new.energy - old.energy) / temperature)
  end
end
