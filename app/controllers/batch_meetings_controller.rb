class BatchMeetingsController < ApplicationController
  def new
    @meetings_form = MeetingForm.new
  end

  def create
    meeting_form = MeetingForm.new(meetings_params)

    if meeting_form.valid?
      GenerateMeetings.call(fraternity: @fraternity, **meeting_form.attributes)

      redirect_to fraternity_meetings_path(@fraternity), notice: notification_for(:created, Meeting)
    else
      render :new
    end
  end

  private

  def meetings_params
    params.fetch(:meeting, {}).permit(:dates, :organizers)
  end
end
