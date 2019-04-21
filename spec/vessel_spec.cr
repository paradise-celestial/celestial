require "./spec_helper"
require "json"

describe Celestial::Vessel do
  it "has a all its attributes when created" do
    vessel = Celestial::Vessel.new name: "library", parent: 0
    json = {
      name:     "library",
      attr:     "",
      note:     "",
      parent:   0,
      owner:    -1,
      triggers: {} of String => String,
    }.to_json
    vessel.to_json.should eq json
  end

  # TODO: Add more specs
end
