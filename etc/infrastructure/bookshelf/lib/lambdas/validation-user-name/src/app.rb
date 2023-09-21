# frozen_string_literal: true

require_relative 'bad_user_name_exception'

# evnet: {
#  "version"=>"1", "region"=>"us-east-1",
#  "userPoolId"=>"<user_pool_id>",
#  "userName"=>"<user_name>",
#  "callerContext"=>{
#    "awsSdkVersion"=>"aws-sdk-unknown-unknown", "clientId"=>"<cognito_client_id>"
#  },
#  "triggerSource"=>"PreSignUp_SignUp",
#  "request"=>{"userAttributes"=>{"email"=>"hogehoge@example.com"}, "validationData"=>nil},
#  "response"=>{"autoConfirmUser"=>false, "autoVerifyEmail"=>false, "autoVerifyPhone"=>false}}
# }
# ref: https://docs.aws.amazon.com/ja_jp/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html#cognito-user-pools-lambda-trigger-syntax-shared
def lambda_handler(event:, context:) # rubocop:disable Lint/UnusedMethodArgument
  puts("event: #{event}")

  bad_user_names = ENV['BAD_USER_NAMES'].split(',')
  user_name = event['userName']
  puts("user_name: #{user_name}")

  raise BadUserNameException, user_name if bad_user_names.include?(user_name)

  event
end
