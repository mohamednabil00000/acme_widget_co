# frozen_string_literal: true

class BaseService
  Response = Struct.new(:success?, :payload, :error) do
    def failure?
      !success?
    end
  end

  def self.call(...)
    service = new(...)
    service.call
  rescue StandardError => e
    service.failure(e)
  end

  def self.call!(...)
    new(...).call
  end

  def success(payload = nil)
    Response.new(true, payload)
  end

  def failure(exception)
    Response.new(false, nil, exception)
  end
end
