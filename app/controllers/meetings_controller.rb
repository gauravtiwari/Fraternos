class MeetingsController < ApplicationController
  def index
    load_meetings
  end

  def show
    load_meeting
    @fraternity = @meeting.fraternity
  end

  def new
    load_fraternity
    build_meeting
  end

  def create
    build_meeting

    if @meeting.save
      redirect_to fraternity_meetings_path(fraternity), notice: notification_for(:created, Meeting)
    else
      render :new
    end
  end

  def edit
    load_fraternity
    load_meeting
  end

  def update
    load_meeting
    build_meeting

    if @meeting.save
      redirect_to fraternity_meetings_path(fraternity), notice: notification_for(:updated, Meeting)
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
    fraternity&.meetings || Meeting.all
  end

  def fraternity
    @fraternity ||= Fraternity.find_by(id: params[:fraternity_id])
  end
  alias load_fraternity fraternity
end
