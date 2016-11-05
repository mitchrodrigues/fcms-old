class AddressRelation < ActiveRecord::Base
  belongs_to :address
  belongs_to :owner, polymorphic: true

  before_create :ensure_start_at
  def ensure_start_at
    self.started_at ||= Time.now
  end
end
