## Map The Future

A crowdsourced touring app that offers new, fresh perspectives on the city to locals and travelers alike!

## API

**Production Base URI**: https://fathomless-savannah-6575.herokuapp.com

Append endpoints to base uri.

**Authentication Notes**:

To make an authenticated request in any case other than registering
or deleting an account, you must supply an `Access-Token` header with
a valid access token. Otherwise, you'll receive a 401 Unauthorized error.

### Creating a User

#### POST `/signup`

**Params**:

`first_name`: String

`last_name`: String

`email`: String, must be unique

`password`: String

**Response**:

If the user was created successfully, you should receive status code 201 and ...

```
{
  "user": {
    "id": 2,
    "first_name": "John",
    "last_name": "Dough",
    "email": "name@email.com",
    "access_token": "9f5b8ebf876121c3fc4c0fa18a511e16"
  }
}
```

If the user could not be created, you should receive status code 422 and ...

```
{
  "error": "Email has already been taken or is invalid."
  ]
}
```

### Viewing a Single User

#### POST `/user/show`

**Params**:

`email`: The user account's email address.

`password`: The user account's password.

**Response**: 

If the request was successful, you should receive status code 200 and ...

```
{
  "user": {
    "id": 2,
    "first_name": "John",
    "last_name": "Dough",
    "email": "name@email.com",
    "access_token": "9f5b8ebf876121c3fc4c0fa18a511e16"
  }
}
```

If the request was not successful, you should receive status code 401 and ...

```
{
"error": "Invalid email or password."
}
```

### Updating a User

#### PATCH `/user/update`

**Query Params**:

`id`: Integer, current user's access token must match the token of the requested user

**Post Params**:

`first_name`: String

`last_name`: String

`email`: String, must be unique

`password`: String

**Response**:

If the request was successful, you should receive status code 202 and ...

```
{
  "user": {
    "id": 2,
    "first_name": "Juan",
    "last_name": "Deaux",
    "email": "name@email.com",
    "access_token": "9f5b8ebf876121c3fc4c0fa18a511e16"
  }
}
```

If the request was not successful, you should receive status code 401 and ...

```
{
"error": "You are not authorized to update this user's information."
}
```

### Deleting a User

#### DELETE `/user/destroy`

**Params**:

`email`: Your user account's email address.
`password`: Your user account's password.

**Response**:

If the request was successful, you should receive status code 202 and ...

`The user has been deleted successfully.`

If the request was unsuccessful, you should receive status code 401 and ...

```
{
  "error": "Invalid email address or password."
}
```

### Displaying an Index of Tours

#### GET `/tours`

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "tours": [
    "tour": {
    "id": 7,
    "user_id": 4,
    "title": "Charleston Gardens",
    "distance": 3,
    "duration": 2,
    "start_lat": "33.8428",
    "start_lon": "84.3857",
    "category": "Food",
    "description": "Lots of topiaries."
  },

    ...
  ]
}
```

If the request failed, you should receive the status code 404 and ...

```
{
  "error": "There are no tours to display."
}
```

### Displaying a Single Tour

#### GET `/tours/:id`

**Query Params**:

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "tour": {
    "id": 7,
    "user_id": 4,
    "title": "Charleston Gardens",
    "distance": 3,
    "duration": 2,
    "start_lat": "33.8428",
    "start_lon": "84.3857",
    "category": "Food",
    "description": "Lots of topiaries."
  }
}
```

If the request failed, you should receive the status code 404 and ...

```
{
  "error": "Could not find object: Couldn't find Tour with 'id'=#{id}"
}
```

### Creating a New Tour

#### POST `/tours`

**Post Params**:

`title`: String

`distance`: Float (in miles)

`duration`: Integer (in hours)

`start_lat`: Decimal (precision: 10, scope: 8)

`start_lon`: Decimal (precision: 10, scope: 8)

`category`: String

`description`: Text

**Response**

If the request was successful, you should receive the status code 201 and ...

```
{
  "tour": {
    "id": 7,
    "user_id": 4,
    "title": "Charleston Gardens",
    "distance": 3,
    "duration": 2,
    "start_lat": "33.8428",
    "start_lon": "84.3857",
    "category": "Food",
    "description": "Lots of topiaries."
  }
}
```

If the request failed, you should receive the status code 422 and ...

```
{
  error: "The tour could not be created."
}
```

### Updating an Existing Tour

#### PATCH `/tours/:id`

**Query Params**:

`id`: Integer

**Post Params**:

`title`: String

`distance`: Float (in miles)

`duration`: Integer (in hours)

`start_lat`: Decimal (precision: 10, scope: 8)

`start_lon`: Decimal (precision: 10, scope: 8)

`category`: String

`description`: Text

**Response**

If the request was successful, you should receive the status code 202 and ...

```
{
  "tour": {
    "id": 7,
    "user_id": 4,
    "title": "Charleston Gardens",
    "distance": 3,
    "duration": 2,
    "start_lat": "33.8428",
    "start_lon": "84.3857",
    "category": "Food",
    "description": "Lots of topiaries."
  }
}
```

If the request was unsuccessful, you should receive the status code 401 and ...

```
{
  error: "You are not authorized to update this tour."
}
```

### Deleting an Exisiting Tour

#### DELETE `/tours/:id`

**Params**

`id`: Integer

**Response**

If the request was successful, you should receive the status code 202 and ...

```
"The tour has been deleted successfully."
```

If the request was unsuccessful, you should receive the status code 401 and ...

```
"error": "You are not authorized to delete this tour."
```
