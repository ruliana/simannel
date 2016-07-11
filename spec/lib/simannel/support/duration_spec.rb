# frozen_string_literal: true

require 'spec_helper'

describe Duration do
  it "converts time to minutes" do
    expect(Duration.new("0min").in_minutes).to eq 0
    expect(Duration.new("1min").in_minutes).to eq 1
    expect(Duration.new("122min").in_minutes).to eq 122
    expect(Duration.new("10 min").in_minutes).to eq 10
    expect(Duration.new(3).in_minutes).to eq 3
    expect(Duration.new("4").in_minutes).to eq 4
  end

  it "explodes if it can't understand time" do
    expect { Duration.new("blah").in_minutes }.to raise_error RuntimeError
    expect { Duration.new("-1min").in_minutes }.to raise_error RuntimeError
    expect { Duration.new("1minute").in_minutes }.to raise_error RuntimeError
    expect { Duration.new("Xmin").in_minutes }.to raise_error RuntimeError
  end

  it 'converts "lightning" to 5 minutes' do
    subject = Duration.new("lightning")
    expect(subject.in_minutes).to eq 5
  end
end
