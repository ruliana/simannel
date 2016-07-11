# frozen_string_literal: true
require 'spec_helper'

describe Talk do
  let(:valid_times) do
    {"1min" => 1,
     "2min" => 2,
     "10 min" => 10,
     "0min" => 0}
  end

  let(:invalid_times) do
    ["1", "-1min"]
  end

  it "convert time to minutes" do
    valid_times.each do |time_description, in_minutes|
      subject = Talk.new("don't care", time_description)
      expect(subject.time_in_minutes).to eq in_minutes
    end
  end

  it "explodes if can't understand time" do
    invalid_times.each do |time_description|
      expect { Talk.new("don't care", time_description) }.to raise_error RuntimeError
    end
  end

  it 'convert "lightning" to 5 minutes' do
    subject = Talk.new("don't care", "lightning")
    expect(subject.time_in_minutes).to eq 5
  end
end

