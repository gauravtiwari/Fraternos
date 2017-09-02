class AttendanceRecordsController < ApplicationController
  def create
    # authorize AttendanceRecord
    @attendance_records =
      SaveAttendances.call(
        meeting: meeting,
        absent_user_ids: params[:attendance_record][:absent_user_ids]&.reject(&:empty?)
      )
    if @attendance_records.right?
      redirect_to fraternity_meeting_path(meeting.fraternity, meeting), notice: notification_for(:created, AttendanceRecord)
    else
      redirect_to fraternity_meeting_path(meeting.fraternity, meeting)
    end
  end

  private

  def meeting
    @meeting ||= Meeting.find_by(id: params[:meeting_id])
  end
end
