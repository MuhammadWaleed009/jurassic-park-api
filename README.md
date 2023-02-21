# Local Development Setup

## Technology stack

- Ruby 2.7.1
- Ruby on Rails 7.0.4
- PostgreSQL 14.5
- Application Server: Puma
- User Authentication: JWT

### Requirements

Before you get started, the following needs to be installed:

- **Ruby**. Version 2.7.1 is currently used and we don't guarantee everything works with other versions. If you need multiple versions of Ruby, [RVM](https://rvm.io//) or [rbenv](https://github.com/rbenv/rbenv) is recommended.
- **Bundler**: `gem install bundler`
- [**Git**](http://help.github.com/git-installation-redirect)
- **A database**. PostgreSQL 14.5 has been tested, so we give no guarantees that other databases (e.g. mySQL) work. You can install PostgreSQL by:

```
sudo apt-get install postgresql-14.5
```

### Setting up the development environment

1.  Get the code. Clone this git repository and check out the latest release:

    ```bash
    git clone https://github.com/
    cd jurassic-park-api
    ```
2. Set JWT secret in .env on root of project
    Generate secret key using `rake secret` 
    
    ```
    DEVISE_JWT_SECRET_KEY=<Your secret key>
    ```

2.  Install the required gems by running the following command in the project root directory:

    ```bash
    bundle install
    ```

3.  Create and populate database with seeds using:

    ```
    rails db:create db:migrate db:seed
    ```

4.  Use the given curl Commands to SignUp and SignIn:

    Use this command to SignUp in your applicaiton: 
    ```
    curl -XPOST -H "Content-Type: application/json" -d '{ "user": { "email": "", "password": "", role: "(doctor/builder/scientist)" } }' http://localhost:3000/users
    ```
    Use this command to SignIn into your applicaiton: 
    ```
    curl -XPOST -i -H "Content-Type: application/json" -d '{ "user": { "email": "", "password": "" } }' http://localhost:3000/users/sign_in
    ```

5.  Check routes to use them for further use of the application:

    `rails routes`

6.  Run server:

    `rails server` or `rails s`

To run test cases: `rspec`

Congratulations! Jurassic Park should now be up and running for development purposes on http://localhost:3000/
