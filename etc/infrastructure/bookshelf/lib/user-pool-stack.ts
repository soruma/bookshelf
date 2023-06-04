import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";
import * as cognito from "aws-cdk-lib/aws-cognito";
import * as ssm from "aws-cdk-lib/aws-ssm";
import * as lambda from "aws-cdk-lib/aws-lambda";

export interface UserPoolStackProps extends cdk.NestedStackProps {
  readonly validationUserNameFunction: lambda.IFunction;
}

export class UserPoolStack extends cdk.NestedStack {
  public readonly stringParameter:ssm.StringParameter;

  constructor(scope: Construct, id: string, props: UserPoolStackProps) {
    super(scope, id, props);

    const domainPrefixParam = new cdk.CfnParameter(this, "DomainPrefix", {
      type: "String",
    });
    const domainPrefix = domainPrefixParam.valueAsString;

    const clientCallbackUrlsParam = new cdk.CfnParameter(this, "ClientCallbackUrls", {
      type: "String",
    });
    const clientCallbackUrls = cdk.Fn.split(",", clientCallbackUrlsParam.valueAsString);

    const clientLogoutUrlsParam = new cdk.CfnParameter(this, "ClientLogoutUrls", {
      type: "String",
    });
    const clientLogoutUrls = cdk.Fn.split(",", clientLogoutUrlsParam.valueAsString);

    const userPool = new cognito.UserPool(this, "UserPool", {
      userPoolName: "BookshelfUserPool",
      accountRecovery: cognito.AccountRecovery.EMAIL_ONLY,
      autoVerify: { email: true },
      deletionProtection: true,
      selfSignUpEnabled: true,
      signInAliases: { username: true, email: true }, // Cognito user pool sign-in options
      signInCaseSensitive: false,
      standardAttributes: {
        email: { required: true, mutable: true },
      },
      keepOriginal: { email: true }, // Verifying attribute changes
    });
    userPool.addDomain("Domain", {
      cognitoDomain: { domainPrefix: domainPrefix },
    });
    userPool.addTrigger(cdk.aws_cognito.UserPoolOperation.PRE_SIGN_UP, props.validationUserNameFunction);

    const clientWriteAttributes =
      new cognito.ClientAttributes().withStandardAttributes({
        fullname: true,
        email: true,
      });

    const clientReadAttributes = clientWriteAttributes.withStandardAttributes({
      emailVerified: true,
    });

    const userPoolClient = userPool.addClient("Client", {
      authFlows: {
        adminUserPassword: true,
      },
      generateSecret: true,
      oAuth: {
        flows: {
          authorizationCodeGrant: true,
        },
        scopes: [cognito.OAuthScope.EMAIL, cognito.OAuthScope.OPENID],
        callbackUrls: clientCallbackUrls,
        logoutUrls: clientLogoutUrls,
      },
      preventUserExistenceErrors: true,
      readAttributes: clientReadAttributes,
      writeAttributes: clientWriteAttributes,
    });

    const bookshelfUserPoolAttributes = {
      UserPoolId: userPool.userPoolId,
      UserPoolClientId: userPoolClient.userPoolClientId,
      UserPoolClientSecret: userPoolClient.userPoolClientSecret.unsafeUnwrap(),
    };

    this.stringParameter = new ssm.StringParameter(
      this,
      "UserPoolAttributes",
      {
        parameterName: "BookshelfUserPoolAttributes",
        stringValue: JSON.stringify(bookshelfUserPoolAttributes),
      }
    );
  }
}
