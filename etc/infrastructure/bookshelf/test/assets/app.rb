# frozen_string_literal: true

def lambda_handler(event:, context:) # rubocop:disable Lint/UnusedMethodArgument
  {
    statusCode: 200,
    body: {
      message: 'Hello World!'
    }.to_json
  }
end
