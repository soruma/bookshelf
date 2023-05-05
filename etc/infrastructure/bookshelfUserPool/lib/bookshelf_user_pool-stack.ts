import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import * as cognito from 'aws-cdk-lib/aws-cognito';
import * as ssm from 'aws-cdk-lib/aws-ssm';

export class BookshelfUserPoolStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const domainPrefixParam = new cdk.CfnParameter(this, 'DomainPrefix', {
      type: 'String',
      default: 'bookshelf',
    });

    const clientCallbackUrlsParam = new cdk.CfnParameter(this, 'ClientCallbackUrls', {
      type: 'CommaDelimitedList',
      default: [
        'http://localhost:3000/auth/signin',
        'http://localhost:3000/auth/signup'
      ].toString(),
    });

    const clientLogoutUrlsParam = new cdk.CfnParameter(this, 'ClientLogoutUrls', {
      type: 'CommaDelimitedList',
      default: [ 'http://localhost:3000/auth/signout' ].toString(),
    });

    const userPool = new cognito.UserPool(this, 'UserPool', {
      userPoolName: 'BookshelfUserPool',
      accountRecovery: cognito.AccountRecovery.EMAIL_ONLY,
      autoVerify: { email: true, },
      deletionProtection: true,
      selfSignUpEnabled: true,
      signInAliases: { username: true, email: true }, // Cognito user pool sign-in options
      signInCaseSensitive: false,
      standardAttributes: {
        email: { required: true, mutable: true },
      },
      keepOriginal: { email: true }, // Verifying attribute changes
    });
    userPool.addDomain('Domain', {
      cognitoDomain: { domainPrefix: domainPrefixParam.valueAsString },
    });

    const clientWriteAttributes = (new cognito.ClientAttributes())
      .withStandardAttributes({fullname: true, email: true});

    const clientReadAttributes = clientWriteAttributes
      .withStandardAttributes({emailVerified: true});

    const userPoolClient = userPool.addClient('Client', {
      authFlows: {
        adminUserPassword: true
      },
      oAuth: {
        flows: {
          authorizationCodeGrant: true,
        },
        scopes: [
          cognito.OAuthScope.EMAIL,
          cognito.OAuthScope.OPENID,
        ],
        callbackUrls: clientCallbackUrlsParam.valueAsList,
        logoutUrls: clientLogoutUrlsParam.valueAsList,
      },
      generateSecret: true,
      preventUserExistenceErrors: true,
      readAttributes: clientReadAttributes,
      writeAttributes: clientWriteAttributes,
    });

    const bookshelfUserPoolAttributes = {
      UserPoolId: userPool.userPoolId,
      UserPoolClientId: userPoolClient.userPoolClientId,
      UserPoolClientSecret: userPoolClient.userPoolClientSecret.unsafeUnwrap(),
    };

    const bookshelfUserPoolStringParameter = new ssm.StringParameter(this, 'UserPoolAttributes', {
      parameterName: 'BookshelfUserPoolAttributes',
      stringValue: JSON.stringify(bookshelfUserPoolAttributes),
    });

    new cdk.CfnOutput(this, 'StringParameterArn', {
      value: bookshelfUserPoolStringParameter.parameterArn,
      exportName: 'BookshelfUserPoolStringParameterArn',
    })
  }
}
