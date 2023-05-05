# BookshelfUserPoolStack

Create Cognito instances

## Useful commands

* `npm run build`   compile typescript to js
* `npm run watch`   watch for changes and compile
* `npm run test`    perform the jest unit tests
* `cdk deploy`      deploy this stack to your default AWS account/region
* `cdk diff`        compare deployed stack with current state
* `cdk synth`       emits the synthesized CloudFormation template

### Example

```bash
cdk deploy \
  --parameters DomainPrefix=bookshelf \
  --parameters ClientCallbackUrls=http://localhost:3000/auth/signin,http://localhost:3000/auth/signup \
  --parameters ClientLogoutUrls=http://localhost:3000/auth/signout
```