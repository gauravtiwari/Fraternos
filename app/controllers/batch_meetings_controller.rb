class BatchMeetingsController < ApplicationController
  def new
    fraternity
    @meetings_form = MeetingForm.new
  end

  def create
    meeting_form = MeetingForm.new(meetings_params)

    if meeting_form.valid?
      GenerateMeetings.call(fraternity: fraternity, **meeting_form.attributes)

      redirect_to fraternity_meetings_path(fraternity), notice: notification_for(:created, Meeting)
    else
      render :new
    end
  end

  private

  def meetings_params
    params.fetch(:meeting, {}).permit(:starts_on, :ends_on, :frequency, :organizers)
  end

  def fraternity
    @fraternity ||= Fraternity.find_by(id: params[:fraternity_id])
  end
end
