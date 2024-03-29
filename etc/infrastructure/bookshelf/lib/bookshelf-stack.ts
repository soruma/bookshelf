import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";
import { UserPoolStack } from "./user-pool-stack";
import { UserPoolLambdaTriggerStack } from "./user-pool-lambda-trigger-stack";

export class BookshelfStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    cdk.Tags.of(this).add("Service", "Bookshelf");

    const userPoolLambdaTriggerStack = new UserPoolLambdaTriggerStack(
      this,
      "UserPoolLambdaTriggerStack"
    );

    const domainPrefixParam = new cdk.CfnParameter(this, "DomainPrefix", {
      type: "String",
      default: "bookshelf",
    });
    const domainPrefix = domainPrefixParam.valueAsString;

    const clientCallbackUrlsParam = new cdk.CfnParameter(
      this,
      "ClientCallbackUrls",
      {
        type: "CommaDelimitedList",
        default: [
          "http://localhost:3000/auth/signin",
          "http://localhost:3000/auth/signup",
        ].toString(),
      }
    );
    const clientCallbackUrls = cdk.Fn.join(
      ",",
      clientCallbackUrlsParam.valueAsList
    );

    const clientLogoutUrlsParam = new cdk.CfnParameter(
      this,
      "ClientLogoutUrls",
      {
        type: "CommaDelimitedList",
        default: ["http://localhost:3000/auth/signout"].toString(),
      }
    );
    const clientLogoutUrls = cdk.Fn.join(
      ",",
      clientLogoutUrlsParam.valueAsList
    );

    const bookshelfUserPoolStack = new UserPoolStack(
      this,
      "BookshelfUserPoolStack",
      {
        parameters: {
          DomainPrefix: domainPrefix,
          ClientCallbackUrls: clientCallbackUrls,
          ClientLogoutUrls: clientLogoutUrls,
        },
        validationUserNameFunction:
          userPoolLambdaTriggerStack.validationUserNameFunction,
      }
    );

    new cdk.CfnOutput(this, "StringParameterArn", {
      value: bookshelfUserPoolStack.stringParameter.parameterArn,
      exportName: "BookshelfUserPoolStringParameterArn",
    });
  }
}
