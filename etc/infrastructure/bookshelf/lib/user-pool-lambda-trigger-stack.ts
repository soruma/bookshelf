import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";
import * as lambda from "aws-cdk-lib/aws-lambda";

export class UserPoolLambdaTriggerStack extends cdk.NestedStack {
  public readonly validationUserNameFunction: lambda.IFunction;

  constructor(scope: Construct, id: string, props?: cdk.NestedStackProps) {
    super(scope, id, props);

    this.validationUserNameFunction = new lambda.DockerImageFunction(
      this,
      "ValidationUserName",
      {
        code: lambda.DockerImageCode.fromImageAsset(
          "./lambdas/validation-user-name"
        ),
        architecture: lambda.Architecture.ARM_64,
        environment: {
          BAD_USER_NAMES: [
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
          ].join(","),
        },
      }
    );
  }
}
