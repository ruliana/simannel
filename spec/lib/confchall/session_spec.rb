# frozen_string_literal: true

require 'spec_helper'

describe Session do
  let(:talk30) { Talk.new("Talk 30min", "30min") }
  let(:talk45) { Talk.new("Talk 45min", "45min") }

  context "with no talk" do
    subject { Session.new("Empty session", 30) }
    it { is_expected.to be_empty }
  end

  context "with talks" do
    subject { Session.new("Empty session", 30, [talk30]) }
    it { is_expected.not_to be_empty }
  end

  describe "#time_violated" do
    context "with fixed time and no talks" do
      subject { Session.new("Empty Session", 60) }
      it "returns the session time" do
        expect(subject.time_violated).to eq 60
      end
    end

    context "with fixed time and one little talk" do
      subject { Session.new("OneTalk Session", 60, [talk30]) }
      it "returns the difference between talk and limit" do
        expect(subject.time_violated).to eq 30
      end
    end

    context "with fixed time and more talks" do
      subject { Session.new("OneTalk Session", 60, [talk30, talk45]) }
      it "returns the difference between talks and limit" do
        expect(subject.time_violated).to eq 15
      end
    end

    context "with range time and no talks" do
      subject { Session.new("Empty Session", 45..60) }
      it "returns minimum session time" do
        expect(subject.time_violated).to eq 45
      end
    end

    context "with range time and one little talk" do
      subject { Session.new("OneTalk Session", 45..60, [talk30]) }
      it "returns the minor difference between talk and limit" do
        expect(subject.time_violated).to eq 15
      end
    end

    context "with range time and one almost enough talk" do
      subject { Session.new("OneTalk Session", 15..25, [talk30]) }
      it "returns the minor difference between talk and limit" do
        expect(subject.time_violated).to eq 5
      end
    end

    context "with range time and more talks" do
      subject { Session.new("OneTalk Session", 60..70, [talk30, talk45]) }
      it "returns the difference between talks and limit" do
        expect(subject.time_violated).to eq 5
      end
    end
  end
end
