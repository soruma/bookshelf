import * as cdk from "aws-cdk-lib";
import * as lambda from "aws-cdk-lib/aws-lambda";
import { Capture, Template } from "aws-cdk-lib/assertions";
import { UserPoolStack } from "../lib/user-pool-stack";

let app: cdk.App;
let stack: cdk.Stack;
let nestedStack: UserPoolStack;
let template: Template;

beforeAll(() => {
  app = new cdk.App();
  stack = new cdk.Stack(app, "Parent");
  nestedStack = new UserPoolStack(stack, "UserPoolStack", {
    parameters: {
      DomainPrefix: "domain",
      ClientCallbackUrls: "callbackurl1,callbackurl2",
      ClientLogoutUrls: "logouturl1,callbackurl2",
    },
    validationUserNameFunction: new lambda.Function(
      stack,
      "ValidationUserNameFunction",
      {
        runtime: lambda.Runtime.RUBY_3_2,
        architecture: lambda.Architecture.ARM_64,
        code: lambda.Code.fromAsset("test/assets"),
        handler: "app.lambda_handler",
      }
    ),
  });
  template = Template.fromStack(nestedStack);
});

test("Cognito UserPool Created", () => {
  template.hasResourceProperties("AWS::Cognito::UserPool", {
    AccountRecoverySetting: {
      RecoveryMechanisms: [{ Name: "verified_email" }],
    },
    AutoVerifiedAttributes: ["email"],
    DeletionProtection: "ACTIVE",
    AdminCreateUserConfig: {
      AllowAdminCreateUserOnly: false, // selfSignUpEnabled
    },
    AliasAttributes: ["email"], // signInAliases
    UsernameConfiguration: {
      CaseSensitive: false,
    },
    Schema: [
      // standardAttributes
      {
        Mutable: true,
        Name: "email",
        Required: true,
      },
    ],
    UserAttributeUpdateSettings: {
      AttributesRequireVerificationBeforeUpdate: [
        // keepOriginal
        "email",
      ],
    },
  });

  const preSignUpCapture = new Capture();
  const userPoolTagsCapture = new Capture();
  template.hasResourceProperties("AWS::Cognito::UserPool", {
    LambdaConfig: {
      PreSignUp: { Ref: preSignUpCapture },
    },
    UserPoolTags: userPoolTagsCapture,
  });
  expect(preSignUpCapture.asString()).toEqual(
    expect.stringMatching(/^referencetoParentValidationUserNameFunction/)
  );
  expect(userPoolTagsCapture.asObject()).toEqual({
    Service: "Bookshelf",
  });
});

test("Cognito UserPoolDomain Created", () => {
  template.hasResourceProperties("AWS::Cognito::UserPoolDomain", {
    Domain: { Ref: "DomainPrefix" },
  });
});

test("Cognito UserPoolClient Created", () => {
  template.hasResourceProperties("AWS::Cognito::UserPoolClient", {
    ExplicitAuthFlows: [
      // authFlows -> adminUserPassword
      "ALLOW_ADMIN_USER_PASSWORD_AUTH",
      "ALLOW_REFRESH_TOKEN_AUTH",
    ],
    GenerateSecret: true,
    AllowedOAuthFlows: ["code"], // oAuth -> flows
    AllowedOAuthScopes: ["email", "openid"], // oAuth -> scopes
    CallbackURLs: { "Fn::Split": [",", { Ref: "ClientCallbackUrls" }] }, // oAuth -> callbackUrls
    LogoutURLs: { "Fn::Split": [",", { Ref: "ClientLogoutUrls" }] }, // oAuth -> logoutUrls
    PreventUserExistenceErrors: "ENABLED", // preventUserExistenceErrors
    ReadAttributes: ["email", "email_verified", "name"],
    WriteAttributes: ["email", "name"],
  });
});
