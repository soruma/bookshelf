import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";
import * as lambda from "aws-cdk-lib/aws-lambda";
import * as path from "path";

export class UserPoolLambdaTriggerStack extends cdk.NestedStack {
  public readonly validationUserNameFunction: lambda.Function;

  constructor(scope: Construct, id: string, props?: cdk.NestedStackProps) {
    super(scope, id, props);

    cdk.Tags.of(this).add("Service", "Bookshelf");

    this.validationUserNameFunction = new lambda.Function(
      this,
      "ValidationUserName",
      {
        architecture: lambda.Architecture.ARM_64,
        code: lambda.Code.fromAsset(
          path.join(__dirname, "lambdas", "/validation-user-name/src")
        ),
        runtime: lambda.Runtime.RUBY_3_2,
        handler: "app.lambda_handler",
      }
    );
    this.validationUserNameFunction.addEnvironment(
      "BAD_USER_NAMES",
      [
        "admin",
        "assets",
        "auth",
        "bookcases",
        "books",
        "rails",
        "refresh_historical_location",
        "signin",
        "signout",
        "signup",
      ].join(",")
    );
  }
}
