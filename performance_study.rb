require_relative './conference_setup.rb'

rslt = 1.upto(10).map do
  spy = {}
  SimulatedAnnealing.new.call(@conference, spy)
  spy
end

counter = rslt.map { |spy| spy[:counter] }.sort
puts counter[(counter.size * 0.05).floor]
puts counter[(counter.size * 0.25).floor]
puts counter[(counter.size * 0.5).floor]
puts counter[(counter.size * 0.75).floor]
puts counter[(counter.size * 0.95).floor]
puts counter.reduce(0, &:+) / counter.size.to_f

rslt = rslt.sort_by { |spy| spy[:counter] }.reverse
max = rslt.first[:counter]
puts "Iterations\t#{rslt.map { |spy| spy[:counter] }.join("\t")}"
0.upto(max - 1).each do |i|
  data = rslt.map { |spy| spy[:energies][i] || "" }
  puts "\t#{data.join("\t")}"
end


