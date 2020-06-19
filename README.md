# API application template using Rails and GraphQL

## Getting Started

For development process, tasks and bugs pls visit our [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/2432730).

### Scripts

* `bin/setup` - build Docker image and prepare DB
* `bin/server` - to run server locally
* `bin/tests` - runs RSpec tests
* `bin/quality` - runs quality tools

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

2. Run setup script

```bash
bin/setup
```

3. Run test and quality suits to make sure all dependencies are satisfied and applications works correctly before making changes.

```bash
bin/tests
```

4. Run application

```bash
bin/server
```
