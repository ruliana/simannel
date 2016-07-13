class SimulatedAnnealing
  def initialize
    @max_iterations = 50
    @max_retries = 40
  end

  def call(state, spy = {})
    return state if state.energy <= 0
    best = state
    counter = 0
    energies = []

    # Retry from best state if it hits a dead end
    @max_retries.times do
      current = best

      # Simulated Anneling
      @max_iterations.times do |iteration|
        counter += 1
        energies << current.energy

        new = current.random_neighbor
        return current if current.energy <= 0

        best = new if new.energy < best.energy
        current = new if transition_probability(current, new, iteration) > rand
      end
    end

    best
  ensure
    spy[:counter] = counter
    spy[:energies] = energies
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
