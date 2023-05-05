import * as cdk from "aws-cdk-lib";
import { Template } from "aws-cdk-lib/assertions";
import * as BookshelfUserPool from "../lib/bookshelf_user_pool-stack";

let app: cdk.App;
let stack: BookshelfUserPool.BookshelfUserPoolStack;
let template: Template;

beforeAll(() => {
  app = new cdk.App();
  stack = new BookshelfUserPool.BookshelfUserPoolStack(
    app,
    "BookshelfUserPoolTestStack"
  );
  template = Template.fromStack(stack);
});

test("Parameter Created", () => {
  template.hasParameter("DomainPrefix", {
    Type: "String",
  });

  template.hasParameter("ClientCallbackUrls", {
    Type: "CommaDelimitedList",
  });

  template.hasParameter("ClientLogoutUrls", {
    Type: "CommaDelimitedList",
  });
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
    CallbackURLs: { Ref: "ClientCallbackUrls" }, // oAuth -> callbackUrls
    LogoutURLs: { Ref: "ClientLogoutUrls" }, // oAuth -> logoutUrls
    PreventUserExistenceErrors: "ENABLED", // preventUserExistenceErrors
    ReadAttributes: ["email", "email_verified", "name"],
    WriteAttributes: ["email", "name"],
  });
});
