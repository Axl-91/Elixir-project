# Elixir REST API Project

Simple REST API Project in Elixir

To run the API:

```
make up
make run
```

## Schemas

### Accounts
1. Email
2. Password
3. User

### Users
1. Full name
2. Gender
3. Biography

There are 9 endpoints to test it, all are located in `localhost:4000/api`

## Endpoints

### GET "/"
Root from api, only displays a welcome message

### POST /accounts/create
Creates a new account.
As parameters it receives in Json format the parameters from the account and user.
It verifies that the email is valid.

### POST /accounts/sign_in
Given a email and a password in Json format it signs in on the API.

### GET /account/:id
Shows the data of the given id

### POST /account/update
Receives an id from an account and the parameters to modify and updates the account

### GET /accounts/sign_out
Signs out the account on the API

### GET /accounts/refresh_session
Refresh the session token

### DELETE /account/delete/:id
Deletes the account that belongs to the given id

### POST /users/update"
Receives an id from the user and the parameters to modify and updates the user
