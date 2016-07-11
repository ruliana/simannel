# frozen_string_literal: true
require 'spec_helper'

describe Conference do
  let(:talks) do
    ts = {"Writing Fast Tests Against Enterprise Rails" => "60min",
          "Overdoing it in Python" => "45min",
          "Lua for the Masses" => "30min",
          "Ruby Errors from Mismatched Gem Versions" => "45min",
          "Common Ruby Errors" => "45min",
          "Rails for Python Developers" => "lightning",
          "Communicating Over Distance" => "60min",
          "Accounting-Driven Development" => "45min",
          "Woah" => "30min",
          "Sit Down and Write" => "30min",
          "Pair Programming vs Noise" => "45min",
          "Rails Magic" => "60min",
          "Ruby on Rails: Why We Should Move On" => "60min",
          "Clojure Ate Scala (on my project)" => "45min",
          "Programming in the Boondocks of Seattle" => "30min",
          "Ruby vs. Clojure for Back-End Development" => "30min",
          "Ruby on Rails Legacy App Maintenance" => "60min",
          "A World Without HackerNews" => "30min",
          "User Interface CSS in Rails Apps" => "30min"}
    ts.map { |k, v| Talk.new(k, v) }
  end

  let(:sessions) do
    t1, t2, t3, t4 = talks.each_slice((talks.size / 4.0).ceil).to_a
    [Session.new("Track1 Morning", 3 * 60, t1),
     Session.new("Track2 Morning", 3 * 60, t2),
     Session.new("Track1 Afternoon", (3 * 60)..(4 * 60), t3),
     Session.new("Track2 Afternoon", (3 * 60)..(4 * 60), t4)]
  end

  subject do
    Conference.new(sessions)
  end

  describe "#organize" do
    it "fits talks to sessions" do
      organized = subject.organize
      expect(organized.time_violated).to eq 0
    end
  end
end
