import * as cdk from "aws-cdk-lib";
import { Template } from "aws-cdk-lib/assertions";
import { BookshelfStack } from "../lib/bookshelf-stack";

let app: cdk.App;
let stack: BookshelfStack;
let template: Template;

beforeAll(() => {
  app = new cdk.App();
  stack = new BookshelfStack(app, "BookshelfTestStack");
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

test("Defined UserPoolStack", () => {
  template.resourceCountIs("AWS::CloudFormation::Stack", 2);
});

test("Output StringParameterArn", () => {
  template.hasOutput("StringParameterArn", {});
});
