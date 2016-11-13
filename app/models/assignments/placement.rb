module Assignments
  class Placement < Assignment

    def duration
      return nil if ended_at.blank?
      time = ((ended_at - started_at).to_i / 2592000.0).round(2)
      time.zero? ? 1 : time
    end
  end
end
