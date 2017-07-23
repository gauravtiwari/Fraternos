require 'rails_helper'

describe GenerateMeetings do
  let(:fraternity) { create(:fraternity, :with_members) }
  let(:frequency) { 1 }
  let(:organizers) { 2 }
  let(:starts_on) { Date.current }
  let(:ends_on) { 10.days.from_now.to_date }
  let(:number_of_days) { (starts_on..ends_on).count }

  let(:result) do
    GenerateMeetings.call(
      fraternity: fraternity, frequency: frequency, organizers: organizers,
      starts_on: starts_on, ends_on: ends_on
    )
  end

  describe '.call' do
    it 'assigns correct number of organizers' do
      expect(result.success?).to eq(true)
      expect(Meeting.first.organizers.count).to eq(organizers)
    end

    (1..3).to_a.each do |n|
      context "with frequency of #{n}" do
        let(:frequency) { n }
        let(:number_of_meetings) { (number_of_days.to_f / frequency).round }

        it 'creates correct number of meetings' do
          expect(result.success?).to eq(true)
          expect(Meeting.count).to eq(number_of_meetings)
        end
      end
    end
  end
end
