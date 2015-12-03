## Map The Future

A crowdsourced touring app that offers new, fresh perspectives on the city to locals and travelers alike!

## API

**Production Base URI**: https://fathomless-savannah-6575.herokuapp.com

Append endpoints to base uri.

**Authentication Notes**:

To make an authenticated request in any case other than registering
or deleting an account, you must supply an `Access-Token` header with
a valid access token. Otherwise, you'll receive a 401 Unauthorized error.

### Table of Contents

- [Users](#)
  - [Creating a User](#)
  - [Viewing a Single User](#)
  - [Updating a User](#)
  - [Deleting a User](#)

- [Tours](#)
  - [Displaying an Index of Tours](#)
  - [Displaying a Single Tour](#)
  - [Creating a New Tour](#)
  - [Updating an Existing Tour](#)
  - [Deleting an Exisiting Tour](#)

- [Sites](#)
  - [Displaying an Index of Sites](#)
  - [Displaying a Single Site](#)
  - [Creating a New Site](#)
  - [Updating an Existing Site](#)
  - [Deleting an Exisiting Site](#)

- [Tour Ratings](#)
  - [Displaying an Index of Tour Ratings](#)
  - [Displaying a Single Rating](#)
  - [Creating a New Rating](#)
  - [Updating an Existing Rating](#)
  - [Deleting an Exisiting Site](#)

## Users

### Creating a User

#### POST `/signup`

**Params**:

`first_name`: String

`last_name`: String

`email`: String, must be unique

`password`: String

`avatar`: File (acceptable formats: png, jpg/jpeg)

**Response**:

If the user was created successfully, you should receive status code 201 and ...

```
{
  "user": {
    "id": 2,
    "first_name": "John",
    "last_name": "Dough",
    "email": "name@email.com",
    "access_token": "9f5b8ebf876121c3fc4c0fa18a511e16",
    "avatar_file_name": "profile_picture.jpg",
    "avatar_url": "tours.s3.amazonaws.com/sites/images/000/000/021/original/
                   profile_picture.jpg"
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
    "access_token": "9f5b8ebf876121c3fc4c0fa18a511e16",
    "avatar_file_name": "profile_picture.jpg",
    "avatar_url": "tours.s3.amazonaws.com/sites/images/000/000/021/original/
                   profile_picture.jpg"
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

#### PATCH `/user/:id/update`

**Query Params**:

`id`: Integer, current user's access token must match the token of the requested user

**Post Params**:

`first_name`: String

`last_name`: String

`email`: String, must be unique

`password`: String

`avatar`: File (acceptable formats: png, jpg/jpeg)

**Response**:

If the request was successful, you should receive status code 202 and ...

```
{
  "user": {
    "id": 2,
    "first_name": "Juan",
    "last_name": "Deaux",
    "email": "name@email.com",
    "access_token": "9f5b8ebf876121c3fc4c0fa18a511e16",
    "avatar_file_name": "profile_picture.jpg",
    "avatar_url": "tours.s3.amazonaws.com/sites/images/000/000/021/original/
                   profile_picture.jpg"
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

## Tours

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

`duration`: Integer (in seconds)

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

`duration`: Integer (in seconds)

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

## Sites

### Displaying an Index of Sites

#### GET `/tours/:id/sites`

**Params**:

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "sites": [
    "site": {
      "id": 7,
      "tour_id": 4,
      "title": "The State Hermitage Museum",
      "description": "A museum of art and culture in Saint Petersburg, Russia.",
      "image_file_name": "hermitage_facade.png",
      "image_url": "tours.s3.amazonaws.com/sites/images/000/000/021/original/
                    hermitage_facade.png",
      "audio_file_name": "hermitage_tour_notes.m4a",
      "audio_url": "tours.s3.amazonaws.com/sites/images/000/000/021/original/tour_notes.mp3",
      "latitude": "59.9410",
      "longitude": "30.3129"
  },

    ...
  ]
}
```

If the request failed, you should receive the status code 404 and ...

```
{
  "error": "Either the tour does not exist, or it has no sites to display."
}
```

### Displaying a Single Site

#### GET `/sites/:id`

**Params**:

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "site": {
    "id": 7,
    "tour_id": 4,
    "title": "The State Hermitage Museum",
    "description": "A museum of art and culture in Saint Petersburg, Russia.",
    "image_file_name": "hermitage_facade.png",
    "image_url": "tours.s3.amazonaws.com/sites/images/000/000/021/original/
                  hermitage_facade.png",
    "audio_file_name": "hermitage_tour_notes.m4a",
    "audio_url": "tours.s3.amazonaws.com/sites/images/000/000/021/original/tour_notes.mp3",
    "latitude": "59.9410",
    "longitude": "30.3129"
  }
}
```

If the request failed, you should receive the status code 404 and ...

```
{
  "error": "Could not find object: Couldn't find Site with 'id'=#{id}"
}
```

### Creating a New Site

#### POST `/tours/:id/sites`

**Query Params**:

`id`: Integer

**Post Params**:

`title`: String

`description`: Text

`image`: File (acceptable formats: png, jpg/jpeg)

`audio`: File (acceptable formats: mp3, m4a)

`latitude`: Decimal (precision: 10, scope: 8)

`longitude`: Decimal (precision: 10, scope: 8)

**Response**

If the request was successful, you should receive the status code 201 and ...

```
{
  "site": {
    "id": 7,
    "tour_id": 4,
    "title": "The State Hermitage Museum",
    "description": "A museum of art and culture in Saint Petersburg, Russia.",
    "image_file_name": "hermitage_facade.png",
    "image_url": "tours.s3.amazonaws.com/sites/images/000/000/021/original/
                  hermitage_facade.png",
    "audio_file_name": "hermitage_tour_notes.m4a",
    "audio_url": "tours.s3.amazonaws.com/sites/images/000/000/021/original/tour_notes.mp3",
    "latitude": "59.9410",
    "longitude": "30.3129"
  }
}
```

If the request failed, you should receive the status code 401 and ...

```
{
  error: "You are not authorized to add a site to this tour."
}
```

### Updating an Existing Site

#### PATCH `/sites/:id`

**Query Params**:

`id`: Integer

**Post Params**:

`title`: String

`description`: Text

`image`: File (acceptable formats: png, jpg/jpeg)

`audio`: File (acceptable formats: mp3, m4a)

`latitude`: Decimal (precision: 10, scope: 8)

`longitude`: Decimal (precision: 10, scope: 8)

**Response**

If the request was successful, you should receive the status code 202 and ...

```
{
  "site": {
    "id": 7,
    "tour_id": 4,
    "title": "The State Hermitage Museum",
    "description": "A museum of art and culture in Saint Petersburg, Russia.",
    "image_file_name": "hermitage_facade.png",
    "image_url": "tours.s3.amazonaws.com/sites/images/000/000/021/original/
                  hermitage_facade.png",
    "audio_file_name": "hermitage_tour_notes.m4a",
    "audio_url": "tours.s3.amazonaws.com/sites/images/000/000/021/original/tour_notes.mp3",
    "latitude": "59.9410",
    "longitude": "30.3129"
  }
}
```

If the request was unsuccessful, you should receive the status code 401 and ...

```
{
  error: "You are not authorized to modify this site."
}
```

### Deleting an Exisiting Site

#### DELETE `/sites/:id`

**Params**

`id`: Integer

**Response**

If the request was successful, you should receive the status code 202 and ...

```
"The site has been deleted successfully."
```

If the request was unsuccessful, you should receive the status code 401 and ...

```
"error": "You are not authorized to delete this site."
```

## Tour Ratings

### Displaying an Index of Tour Ratings

#### GET `/tours/:id/ratings`

**Params**:

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "ratings": [
    "rating": {
      "id": 7,
      "score": 4,
      "rateable_id": 3,
      "rateable_type": "Tour",
  },

    ...
  ]
},
```

If the request failed, you should receive the status code 404 and ...

```
{
  "error": "Either the tour does not exist, or it has no ratings to display."
}
```

### Displaying a Single Rating

#### GET `/ratings/:id`

**Params**:

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "rating": {
      "id": 7,
      "score": 4,
      "rateable_id": 3,
      "rateable_type": "Tour",
}
```

If the request failed, you should receive the status code 404 and ...

```
{
  "error": "Could not find object: Couldn't find Rating with 'id'=#{id}"
}
```

### Creating a New Rating

#### POST `/tours/:id/ratings`

**Query Params**:

`id`: Integer

**Post Params**:

`score`: Integer (1 <= score <= 5)

**Response**

If the request was successful, you should receive the status code 201 and ...

```
{
  "rating": {
      "id": 7,
      "score": 4,
      "rateable_id": 3,
      "rateable_type": "Tour",
  }
}
```

If the request failed, you should receive the status code 400 and ...

```
{
  error: "You must enter a valid rating (1 - 5)"
}
```

### Updating an Existing Rating

#### PATCH `/ratings/:id`

**Query Params**:

`id`: Integer

**Post Params**:

`score`: Integer (1 <= score <= 5)

**Response**

If the request was successful, you should receive the status code 202 and ...

```
{
  "rating": {
      "id": 7,
      "score": 4,
      "rateable_id": 3,
      "rateable_type": "Tour",
  }
}
```

If the request was unsuccessful, you should receive the status code 401 and ...

```
{
  error: "You are not authorized to modify this site."
}
```

### Deleting an Exisiting Site

#### DELETE `/ratings/:id`

**Params**

`id`: Integer

**Response**

If the request was successful, you should receive the status code 202 and ...

```
"The rating has been deleted successfully."
```

If the request was unsuccessful, you should receive the status code 401 and ...

```
"error": "You are not authorized to delete this rating."
```

