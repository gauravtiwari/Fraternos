module SoftDeletable
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted_at: nil) }

    scope :with_deleted, -> { unscoped }
  end

  def deleted?
    deleted_at.present?
  end

  def soft_delete
    update(deleted_at: Time.zone.now)
  end
end
