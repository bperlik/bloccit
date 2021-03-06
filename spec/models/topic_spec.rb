require 'rails_helper'

RSpec.describe Topic, type: :model do
 #  let(:name) { RandomData.random_sentence }
 #  let(:description) {RandomData.random_paragraph }
 #  let(:public) { true }
 #  let(:topic) { Topic.create!(name: name, description: description) }

    let (:topic) { create(:topic) }

  # test to respond to attributes
  describe "attributes" do
    it "has name, description, and public attributes" do
 #   expect(topic).to have_attributes(name: name, description: description, public: public)
     expect(topic).to have_attributes(name: topic.name, description: topic.description)
    end

    # test that public attribute is true by default
    it "is public by default" do
      expect(topic.public).to be (true)
    end

    # test using Shoulda gem relationship methods
    it { is_expected.to have_many(:posts) }
  end
end
