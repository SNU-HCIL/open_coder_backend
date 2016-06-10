module Timestamp extend ActiveSupport::Concern
    def created_at_i
        self.created_at.to_time.to_i
    end

    def updated_at_i
        self.created_at.to_time.to_i
    end
end