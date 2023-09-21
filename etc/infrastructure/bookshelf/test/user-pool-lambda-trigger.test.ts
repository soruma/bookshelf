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
  const codeCapture = new Capture();
  const environmentCapture = new Capture();
  const tagsCapture = new Capture();
  template.hasResourceProperties("AWS::Lambda::Function", {
    Code: codeCapture,
    Environment: environmentCapture,
    Handler: "app.lambda_handler",
    Tags: tagsCapture,
  });

  expect(codeCapture.asObject()).toEqual({
    S3Bucket: {
      "Fn::Sub": expect.stringContaining("assets"),
    },
    S3Key: expect.stringContaining(".zip"),
  });
  expect(environmentCapture.asObject()).toEqual({
    Variables: {
      BAD_USER_NAMES: expect.stringContaining("admin"),
    },
  });
  expect(tagsCapture.asArray()).toContainEqual({
    Key: "Service",
    Value: "Bookshelf",
  });
});
