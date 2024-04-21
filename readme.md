# Petify API

## User

### user list
##### GET: /api/user -> User[]

### login
#### POST: /api/user/login -> User
#### body: LoginForm

### signup
#### POST: /api/user/signup -> User
#### body: UserForm

### update
#### PATCH: /api/user -> User
#### body: PartialUser

## Pet

### user pet list
#### GET: /api/pet -> Pet[]
#### params: user_id = string

### new pet
#### POST: /api/pet -> Pet
#### body: PetForm