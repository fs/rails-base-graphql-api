### Summary

A brief description of the pull request.

### Screenshots, screencasts

Screenshots/screencasts of the pull request introduced functionality.

### Test plan

List of steps to manually test introduced functionality:

* Go to Application
* Sign in
* ...

### Review notes

While reviewing pull-request (especially when it's your pull-request),
please make sure that:

- you understand what problem is solved by PR and how is it solved
- new tests are in place, no redundant tests
- DB schema changes reflect new migrations
- newly introduced DB fields have indexes and constraints
- routes are RESTful, no useless routes
- there are no missed files (migrations, view templates)
- required ENV variables added and described in `.env.example` and added to Heroku
- associated Heroku review app works correctly with introduced changes

### Deploy notes

Notes regarding deployment the contained body of work.
These should note any db migrations, ENV variables, services, scripts, etc.

### References
* [GitHub Issue ####](https://github.com/drapergem/draper/issues/####)
* [GitHub Pull Request ####](https://github.com/drapergem/draper/pull/####)
