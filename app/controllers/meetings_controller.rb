class MeetingsController < ApplicationController
  def index
    load_meetings
  end

  def show
    load_meeting
  end

  def new
    build_meeting
  end

  def create
    build_meeting

    if @meeting.save
      redirect_to fraternity_meetings_path(@fraternity), notice: notification_for(:created, Meeting)
    else
      render :new
    end
  end

  def edit
    load_meeting
  end

  def update
    load_meeting
    build_meeting

    if @meeting.save
      redirect_to fraternity_meetings_path(@fraternity), notice: notification_for(:updated, Meeting)
    else
      render :new
    end
  end

  private

  def meetings_params
    params.fetch(:meeting, {}).permit(:date, organizer_ids: [])
  end

  def build_meeting
    @meeting ||= meetings_scope.build
    @meeting.attributes = meetings_params
  end

  def load_meeting
    @meeting ||= meetings_scope.find_by(id: params[:id])
  end

  def load_meetings
    @meetings ||= meetings_scope.ordered
  end

  def meetings_scope
    @fraternity.meetings || Meeting.all
  end
end
