require 'rails_helper'

describe GenerateMeetings do
  let(:fraternity) { create(:fraternity, :with_members) }
  let(:organizers) { 2 }
  let(:dates) { ['2017-01-01', '2017-01-15', '2017-01-30'] }

  let(:result) do
    GenerateMeetings.call(
      fraternity: fraternity, organizers: organizers, dates: dates
    )
  end

  describe '.call' do
    it 'assigns correct number of organizers' do
      expect(result.success?).to eq(true)
      expect(Meeting.first.organizers.count).to eq(organizers)
    end

    it 'creates correct number of meetings' do
      expect(result.success?).to eq(true)
      expect(Meeting.count).to eq(dates.count)
    end
  end
end
