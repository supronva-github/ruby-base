module Validate
  def validate?
    validate!
    true
  rescue ArgumentError
    false
  end
end
