# frozen_string_literal: true

class BaseSerializer
  def self.item(item)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def self.collection(items)
    items.map { |item| item(item) }
  end
end
