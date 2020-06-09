# API application template using Rails and GraphQL

## Getting Started

For development process, tasks and bugs pls visit our [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/2432730).

### Scripts

* `bin/setup` - build Docker image and prepare DB
* `bin/server` - to run server locally
* `bin/tests` - runs RSpec tests
* `bin/quality` - runs quality tools

### For Linux/Windows users

We use `docker-sync` library to speed up performance on Mac OSX. Please install dependencies specified below or change `docker-compose.yml` to disable docker-sync.

##### Linux

```bash
sudo apt-get install build-essential ocaml
wget https://github.com/bcpierce00/unison/archive/v2.51.2.tar.gz
tar xvf v2.51.2.tar.gz
cd unison-2.51.2
make UISTYLE=text
sudo cp src/unison /usr/local/bin/unison
sudo cp src/unison-fsmonitor /usr/local/bin/unison-fsmonitor
```

##### Windows

Use [the next guide](https://docker-sync.readthedocs.io/en/latest/getting-started/installation.html#windows) to install docker-sync on Windows Subsystem for Linux.

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
