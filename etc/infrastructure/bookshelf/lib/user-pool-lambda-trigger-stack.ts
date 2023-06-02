import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";

export class UserPoolLambdaTriggerStack extends cdk.NestedStack {
  constructor(scope: Construct, id: string, props?: cdk.NestedStackProps ) {
    super(scope, id, props);

  }
}
