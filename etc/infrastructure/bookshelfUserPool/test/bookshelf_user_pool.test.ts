import * as cdk from 'aws-cdk-lib';
import { Capture, Template } from 'aws-cdk-lib/assertions';
import * as BookshelfUserPool from '../lib/bookshelf_user_pool-stack';

test('Cognito UserPoolClient  Created', () => {
  const app = new cdk.App();
  const stack = new BookshelfUserPool.BookshelfUserPoolStack(app, 'BookshelfUserPoolTestStack');
  const template = Template.fromStack(stack);

  template.hasParameter('DomainPrefix', {
    Type: 'String'
  });

  template.hasParameter('ClientCallbackUrls', {
    Type: 'CommaDelimitedList'
  });

  template.hasParameter('ClientLogoutUrls', {
    Type: 'CommaDelimitedList'
  });

  const allowedOAuthFlows = new Capture();
  template.hasResourceProperties("AWS::Cognito::UserPoolClient", {
    AllowedOAuthFlows: allowedOAuthFlows,
  });
  expect(allowedOAuthFlows.asArray()).toEqual(
    expect.arrayContaining(['code'])
  );
  
  const allowedOAuthScopes = new Capture();
  template.hasResourceProperties("AWS::Cognito::UserPoolClient", {
    AllowedOAuthScopes: allowedOAuthScopes,
  });
  expect(allowedOAuthScopes.asArray()).toEqual(
    expect.arrayContaining(['email', 'openid'])
  );

  const explicitAuthFlows = new Capture();
  template.hasResourceProperties("AWS::Cognito::UserPoolClient", {
    ExplicitAuthFlows: explicitAuthFlows,
  });
  expect(explicitAuthFlows.asArray()).toEqual(
    expect.arrayContaining(['ALLOW_ADMIN_USER_PASSWORD_AUTH'])
  );

  template.hasResourceProperties("AWS::Cognito::UserPoolClient", {
    GenerateSecret: true,
  });
  template.hasResourceProperties("AWS::Cognito::UserPoolClient", {
    PreventUserExistenceErrors: 'ENABLED',
  });

  const callbackUrls = new Capture();
  template.hasResourceProperties("AWS::Cognito::UserPoolClient", {
    CallbackURLs: callbackUrls,
  });
  expect(explicitAuthFlows.asArray()).toEqual(
    expect.arrayContaining(['ALLOW_ADMIN_USER_PASSWORD_AUTH'])
  );


  /*
    callbackUrls: clientCallbackUrlsParam.valueAsList,
    logoutUrls: clientLogoutUrlsParam.valueAsList,
  },
  readAttributes: clientReadAttributes,
  writeAttributes: clientWriteAttributes,
  */
});
