class MeetingsController < ApplicationController
  def index
    authorize @fraternity, :show?
    load_meetings
  end

  def show
    load_meeting
    authorize @meeting
  end

  def new
    build_meeting
    authorize @meeting
  end

  def create
    build_meeting
    authorize @meeting

    if @meeting.save
      redirect_to fraternity_meetings_path(@fraternity), notice: notification_for(:created, Meeting)
    else
      render :new
    end
  end

  def edit
    load_meeting
    authorize @meeting
  end

  def update
    load_meeting
    authorize @meeting
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
    @meetings ||= meetings_scope.upcoming
  end

  def meetings_scope
    @fraternity.meetings || Meeting.all
  end
end
