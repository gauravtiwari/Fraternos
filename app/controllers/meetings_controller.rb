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
      params[:organizers].each do |organizer|
        @meeting.organizer_assignation.create(organizer: organizer)
      end

      redirect_to fraternity_meetings_path(fraternity), notice: notification_for(:created, Meeting)
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
      @meeting.organizer_assignation.delete_all

      params[:organizers].each do |organizer|
        @meeting.organizer_assignation.create(organizer: organizer)
      end

      redirect_to fraternity_meetings_path(fraternity), notice: notification_for(:created, Meeting)
    else
      render :new
    end
  end

  private

  def meetings_params
    params.fetch(:meeting, {}).permit(:date)
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
