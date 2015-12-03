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

* [Users](#user-endpoints)
  * [Creating a User](#create-user)
  * [Viewing a Single User](#show-user)
  * [Updating a User](#update-user)
  * [Deleting a User](#delete-user)

* [Tours](#tour-endpoints)
  * [Displaying an Index of Tours](#index-tours)
  * [Displaying a Single Tour](#show-tour)
  * [Creating a New Tour](#create-tour)
  * [Updating an Existing Tour](#update-tour)
  * [Deleting an Exisiting Tour](#delete-tour)

* [Sites](#site-endpoints)
  * [Displaying an Index of Sites](#index-sites)
  * [Displaying a Single Site](#show-site)
  * [Creating a New Site](#create-site)
  * [Updating an Existing Site](#update-site)
  * [Deleting an Exisiting Site](#delete-site)

* [Tour Ratings](#tr-endpoints)
  * [Displaying an Index of Tour Ratings](#index-tr)
  * [Displaying a Single Rating](#show-tr)
  * [Creating a New Rating](#create-tr)
  * [Updating an Existing Rating](#update-tr)
  * [Deleting an Exisiting Site](#delete-tr)

##<a name="user-endpoints"></a> Users

###<a name="create-user"></a> Creating a User

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

###<a name="show-user"></a> Viewing a Single User

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

###<a name="update-user"></a> Updating a User

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

###<a name="delete-user"></a> Deleting a User

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

##<a name="tour-endpoints"></a> Tours

###<a name="index-tours"></a> Displaying an Index of Tours

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

###<a name="show-tour"></a> Displaying a Single Tour

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

###<a name="create-tour"></a> Creating a New Tour

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

###<a name="update-tour"></a> Updating an Existing Tour

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

###<a name="delete-tour"></a> Deleting an Exisiting Tour

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

##<a name="site-endpoints"></a> Sites

###<a name="index-sites"></a> Displaying an Index of Sites

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

###<a name="show-site"></a> Displaying a Single Site

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

###<a name="create-site"></a> Creating a New Site

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

###<a name="update-site"></a> Updating an Existing Site

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

###<a name="delete-site"></a> Deleting an Exisiting Site

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

##<a name="tr-endpoints"></a> Tour Ratings

###<a name="index-tr"></a> Displaying an Index of Tour Ratings

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

###<a name="show-tr"></a> Displaying a Single Tour Rating

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

###<a name="create-tr"></a> Creating a New Tour Rating

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

###<a name="update-tr"></a> Updating an Existing Rating

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

###<a name="delete-tr"></a> Deleting an Exisiting Site

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

