# Simulated Anneling with Lam Schedule
# http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.95.2024&rep=rep1&type=pdf
class SimulatedAnnealingLamSchedule
  def initialize
    @max_iterations = 5000
  end

  def call(state)
    current = state
    temperature = 0.5
    accept_rate = 0.5

    @max_iterations.times do |iteration|
      return current if current.energy <= 0

      new = current.random_neighbor

      if new.energy < current.energy
        current = new
      else
        if Math.exp((current.energy - new.energy) / temperature) > rand
          current = new
          accept_rate = 1 / 500 * (499 * accept_rate + 1)
        else
          accept_rate = 1 / 500 * (499 * accept_rate)
        end
      end

      progress = iteration.to_f / @max_iterations
      if progress < 0.15
        lam_rate = 0.44 + 0.56 * 560 ** (-iteration.to_f / @max_iterations / 0.15)
      elsif progress >= 0.15 && progress < 0.65
        lam_rate = 0.44
      else
        lam_rate = 0.44 * 440 ** -(iteration.to_f / @max_iterations - 0.65) / 0.35
      end

      if accept_rate > lam_rate
        temperature *= 0.999
      else
        temperature /= 0.999
      end
    end
    current
  end
end

