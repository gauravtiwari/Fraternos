class MeetingsController < ApplicationController
  def index
    load_meetings
  end

  def new
    fraternity
    @meetings_form = MeetingForm.new
  end

  def create
    meeting_form = MeetingForm.new(meetings_params)

    if meeting_form.valid?
      GenerateMeetings.call(fraternity: fraternity, organizers: fraternity.users, **meeting_form.attributes)
      
      redirect_to fraternity_meetings_path(fraternity), notice: notification_for(:created, Meeting)
    else
      render :new
    end
  end

  private

  def meetings_params
    params.fetch(:meeting, {}).permit(:starts_on, :ends_on, :frequency, :organizers)
  end

  def build_meeting
    @meeting ||= meetings_scope.build
    @meeting.attributes = meetings_params
  end

  def load_meeting
    @meeting ||= meetings_scope.find_by(id: params[:id])
  end

  def load_meetings
    @meetings ||= meetings_scope
  end

  def meetings_scope
    fraternity&.meetings&.ordered || Meeting.ordered
  end

  def fraternity
    @fraternity ||= Fraternity.find_by(id: params[:fraternity_id])
  end
end
