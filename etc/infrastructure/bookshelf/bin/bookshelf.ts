#!/usr/bin/env node
import "source-map-support/register";
import * as cdk from "aws-cdk-lib";
import { BookshelfStack } from "../lib/bookshelf-stack";

const app = new cdk.App();

new BookshelfStack(app, "BookshelfStack");
