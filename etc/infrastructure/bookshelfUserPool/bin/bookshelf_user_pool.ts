#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { BookshelfUserPoolStack } from '../lib/bookshelf_user_pool-stack';

const app = new cdk.App();

new BookshelfUserPoolStack(app, 'BookshelfUserPoolStack');