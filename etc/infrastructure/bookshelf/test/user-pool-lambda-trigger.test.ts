import * as cdk from "aws-cdk-lib";
import { Capture, Template } from "aws-cdk-lib/assertions";
import { UserPoolLambdaTriggerStack } from "../lib/user-pool-lambda-trigger-stack";

let app: cdk.App;
let stack: cdk.Stack;
let nestedStack: UserPoolLambdaTriggerStack;
let template: Template;

beforeAll(() => {
  app = new cdk.App();
  stack = new cdk.Stack(app, "Parent");
  nestedStack = new UserPoolLambdaTriggerStack(
    stack,
    "UserPoolLambdaTriggerStack"
  );
  template = Template.fromStack(nestedStack);
});

test("Lambda function for ValidationUserNameFunction Created", () => {
  const imageUriCapture = new Capture();
  const environmentCapture = new Capture();
  template.hasResourceProperties("AWS::Lambda::Function", {
    Architectures: ["arm64"],
    Code: {
      ImageUri: imageUriCapture,
    },
    Environment: environmentCapture,
  });

  expect(imageUriCapture.asObject()).toEqual({
    "Fn::Sub": expect.stringContaining("ecr"),
  });
  expect(environmentCapture.asObject()).toEqual({
    Variables: {
      BAD_USER_NAMES: expect.stringContaining("admin"),
    },
  });
});
