class SimulatedAnnealing
  def initialize
    @max_iterations = 1000
    @max_retries = 5
  end

  def call(state)
    best = state

    # Retry from best state if it hits a dead end
    @max_retries.times do
      current = best

      # Simulated Anneling
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
    # If new is better then old, probability of
    # transition is 100%
    return 1 if new.energy < old.energy

    # Temperature must positive and decreasing through
    # iterations until zero. Doens't need to be
    # between 0 and 1. Integers are OK.
    temperature = @max_iterations - iteration

    # (old - new) must be negative, can be integer.
    Math.exp((old.energy - new.energy) / temperature)
  end
end
