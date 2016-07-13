# frozen_string_literal: true
$LOAD_PATH << File.join(__dir__, "lib")
require 'confchall'

talks = [["Writing Fast Tests Against Enterprise Rails", "60min"],
         ["Overdoing it in Python", "45min"],
         ["Lua for the Masses", "30min"],
         ["Ruby Errors from Mismatched Gem Versions", "45min"],
         ["Common Ruby Errors", "45min"],
         ["Rails for Python Developers", "lightning"],
         ["Communicating Over Distance", "60min"],
         ["Accounting-Driven Development", "45min"],
         ["Woah", "30min"],
         ["Sit Down and Write", "30min"],
         ["Pair Programming vs Noise", "45min"],
         ["Rails Magic", "60min"],
         ["Ruby on Rails: Why We Should Move On", "60min"],
         ["Clojure Ate Scala (on my project)", "45min"],
         ["Programming in the Boondocks of Seattle", "30min"],
         ["Ruby vs. Clojure for Back-End Development", "30min"],
         ["Ruby on Rails Legacy App Maintenance", "60min"],
         ["A World Without HackerNews", "30min"],
         ["User Interface CSS in Rails Apps", "30min"]]

sessions = [["Track1 Morning", 3 * 60],
            ["Track2 Morning", 3 * 60],
            ["Track1 Afternoon", (3 * 60)..(4 * 60)],
            ["Track2 Afternoon", (3 * 60)..(4 * 60)]]

talks = talks.map { |(name, duration)| Talk.new(name, duration) }

talks_per_session = (talks.size / sessions.size.to_f).ceil
ts = talks.each_slice(talks_per_session)
sessions = sessions.zip(ts).map do |(name, limit), talks|
  Session.new(name, limit, talks)
end

@conference = Conference.new(sessions)

