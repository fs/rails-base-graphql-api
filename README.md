# API application template using Rails and GraphQL

## Getting Started

For development process, tasks and bugs pls visit our [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/2432730).

### Scripts

* `bin/setup` - build Docker image and prepare DB
* `bin/server` - to run server locally
* `bin/tests` - runs RSpec tests
* `bin/quality` - runs quality tools
* `bin/docker-sync` - install docker-sync library to speed up performance on Mac OSX

### Staging Environments
GraphQL query base path
```bash
https://rails-base-graphql-api.herokuapp.com/graphql
```

#### Apps and extensions for GraphQL

1. Electron-based wrapper around GraphQL [GraphiQL](https://www.electronjs.org/apps/graphiql)
2. Chrome extension [Altair GraphQL Client](https://chrome.google.com/webstore/detail/altair-graphql-client/flnheeellpciglgpaodhkhmapeljopja)

#### How to start working with GraphQL:
1. Choose your favorite tool for working with GraphQL
2. Create a request for signup to get access and refresh tokens
```ruby
# query
mutation signup($email: String!, $password: String!) {
  signup(email: $email, password: $password) {
    me {
      id
      email
    }
    accessToken
    refreshToken
  }
}

# query variables
{ "email": "user@example.com", "password": "password" }
```
3. Use this token to send the following requests. Token sent to the "Authorization" in the header
#### Header example

```ruby
Authorization: Bearer <token>
```

### Bootstrap and run application


1. Clone application repository

```bash
git clone git://github.com/fs/rails-base-graphql-api.git --origin rails-base-graphql-api [MY-NEW-PROJECT]
```

Create your new repo on GitHub and push master into it.
Make sure master branch is tracking origin repo.

```bash
git remote add origin git@github.com:[MY-GITHUB-ACCOUNT]/[MY-NEW-PROJECT].git
git push -u origin master
```

2. Run docker-sync setup script (optional, for Mac OSX users)

```bash
bin/docker-sync
```

3. Run setup script

```bash
bin/setup
```

4. Run test and quality suits to make sure all dependencies are satisfied and applications works correctly before making changes.

```bash
bin/tests
```

4. Run application

```bash
bin/server
```
