module Scalingo
  def generate_test_jwt(duration: nil)
    payload = {iss: "Scalingo Test"}
    payload[:exp] = Time.now.to_i + duration.to_i if duration.present?

    JWT.encode payload, nil, "none"
  end

  module_function :generate_test_jwt
end
