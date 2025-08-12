# frozen_string_literal: true

class ApplicationContract < Dry::Validation::Contract
  def self.check(data)
    self.new.call(process_data(data))
  end

  private

  def self.process_data(data)
    data = data.to_unsafe_h if data.is_a?(ActionController::Parameters)
    if !data.is_a?(ActionController::Parameters) && !data.is_a?(Hash) && data.respond_to?(:as_json)
      data = data.as_json
    end
    data
  end
end
