## Map The Future

A crowdsourced touring app that offers new, fresh perspectives on the city to locals and travelers alike!

## API

**Production Base URI**: https://fathomless-savannah-6575.herokuapp.com

Append endpoints to base uri.

**Authentication Notes**:

To make an authenticated request, you must supply an `Access-Token` header 
with a valid access token. Otherwise, you'll receive a 401 Unauthorized error. 
Authentication is required for all POST, PATCH and DELETE requests.

### Table of Contents

* [Registration](#registration-endpoints)
  * [Creating a User](#create-user)
  * [Viewing a Single User](#show-user)
  * [Updating a User](#update-user)
  * [Deleting a User](#delete-user)

* [Tours](#tour-endpoints)
  * [Displaying an Index of Tours](#index-tours)
  * [Displaying an Index of Nearby Tours](#nearby-tours)
  * [Displaying a Single Tour](#show-tour)
  * [Creating a New Tour](#create-tour)
  * [Updating an Existing Tour](#update-tour)
  * [Deleting an Existing Tour](#delete-tour)
  * [Getting All The Users Who've Favorited a Specific Tour](#favorited-tour)

* [Sites](#site-endpoints)
  * [Displaying an Index of Sites](#index-sites)
  * [Displaying a Single Site](#show-site)
  * [Creating a New Site](#create-site)
  * [Creating Multiple Sites at Once](#create-many)
  * [Updating an Existing Site](#update-site)
  * [Deleting an Existing Site](#delete-site)

* [Tour/Site Ratings](#tr-endpoints)
  * [Displaying an Index of Tour Ratings](#index-tr)
  * [Displaying a Single Rating](#show-tr)
  * [Creating a New Rating](#create-tr)
  * [Updating an Existing Rating](#update-tr)
  * [Deleting an Existing Site](#delete-tr)

* [Reviews](#review-endpoints)
  * [Displaying an Index of Reviews](#index-reviews)
  * [Displaying a Single Review](#show-review)
  * [Creating a New Review](#create-review)
  * [Updating an Existing Review](#update-review)
  * [Deleting an Existing Review](#delete-review)

* [Users](#user-endpoints)
  * [Displaying a User's Tour Ratings](#tr-user)
  * [Displaying a User's Site Ratings](#sr-user)
  * [Displaing a User's Tour Reviews](#reviews-user)
  * [Displaying a User's Favorite Tours](#favorites-user)

* [Favorites](#favorite-endpoints)
  * [Creating a Favorite](#create-favorite)
  * [Deleting a Favorite](#destroy-favorite)

##<a name="registration-endpoints"></a>Registration

###<a name="create-user"></a>Creating a User

#### POST `/signup`

**Params**:

`first_name`: String (required)

`last_name`: String

`email`: String, must be unique (required)

`password`: String (required)

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
}
```

###<a name="show-user"></a>Viewing a Single User

#### POST `/user/show`

**Params**:

`email`: The user account's email address (required)

`password`: The user account's password (required)

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

###<a name="update-user"></a>Updating a User

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

###<a name="delete-user"></a>Deleting a User

#### DELETE `/user/destroy`

**Params**:

`email`: Your user account's email address (required)

`password`: Your user account's password (required)

**Response**:

If the request was successful, you should receive status code 202 and ...

`The user has been deleted successfully.`

If the request was unsuccessful, you should receive status code 401 and ...

```
{
  "error": "Invalid email address or password."
}
```

##<a name="tour-endpoints"></a>Tours

###<a name="index-tours"></a>Displaying an Index of All Tours

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

###<a name="nearby-tours"></a>Displaying an Index of Tours Within an Area

#### POST `/tours`

This endpoint returns tours within a certain area based on three params:

**Params**:

`latitude`: The latitude of the center point of your search area

`longitude`: The longitude of the center point of your search area

`radius`: The radius of your search area (in miles)

Note: Tours are returned in ascending order based on the distance of their starting lat and lon from the origin point.

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "tours": [
    "tour": {
      "id": 7,
      "user_id": 4,
      "title": "Charleston Gardens",
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

###<a name="show-tour"></a>Displaying a Single Tour

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

###<a name="create-tour"></a>Creating a New Tour

#### POST `/tours`

**Post Params**:

`title`: String (required)

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

###<a name="update-tour"></a>Updating an Existing Tour

#### PATCH `/tours/:id`

**Query Params**:

`id`: Integer

**Post Params**:

`title`: String 

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

###<a name="delete-tour"></a>Deleting an Existing Tour

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
{
  "error": "You are not authorized to delete this tour."
}
```

###<a name="favorited-tour"></a>Getting All The Users Who've Favorited a Specific Tour

#### GET `/tours/:id/favorited`

**Params**:

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "users": [
    {
      "id": 3,
      "first_name": "Jean",
      "last_name": "Deaux",
      "email": "jean@email.com"
    },

  ...
  ]
}
```

If the requested tour exists but the request failed, you should receive the status code 204 and ...

```
{
  "error": "This tour hasn't been favorited by anyone yet."
}
```

##<a name="site-endpoints"></a>Sites

###<a name="index-sites"></a>Displaying an Index of Sites

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

###<a name="show-site"></a>Displaying a Single Site

#### GET `/sites/:id`

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
  "error": "Could not find object: Couldn't find Site with 'id'=#{id}"
}
```

###<a name="create-site"></a>Creating a New Site

#### POST `/tours/:id/sites`

**Query Params**:

`id`: Integer

**Post Params**:

`title`: String (required)

`description`: Text

`image`: File (acceptable formats: png, jpg/jpeg)

`audio`: File (acceptable formats: mp3, m4a)

`latitude`: Decimal (precision: 10, scope: 8) (required)

`longitude`: Decimal (precision: 10, scope: 8) (required)

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
  "error": "You are not authorized to add a site to this tour."
}
```

###<a name="create-many"></a>Creating Multiple Sites at Once

#### POST `/tours/:id/many_sites`

**Query Params**:

`id`: Integer

**Post Params**:

#####*Important* 

`sites` is the only post parameter, but therein you must include an array that includes the following key => value pairs:

`title`: String (required)

`description`: Text

`image`: File (acceptable formats: png, jpg/jpeg)

`audio`: File (acceptable formats: mp3, m4a)

`latitude`: Decimal (precision: 10, scope: 8) (required)

`longitude`: Decimal (precision: 10, scope: 8) (required)

**Response**

If the request was successful, you should receive the status code 201 and ...

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

If the request failed, you should receive the status code 401 and ...

```
{
  "error": ActiveRecord Exception (varies)
}
```

###<a name="update-site"></a>Updating an Existing Site

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
  "error": "You are not authorized to modify this site."
}
```

###<a name="delete-site"></a>Deleting an Existing Site

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

##<a name="tr-endpoints"></a>Ratings

###<a name="index-tr"></a>Displaying an Index of Ratings

#### GET `/tours/:id/ratings` (tour ratings)
#### GET `/sites/:id/ratings` (site ratings)

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
  "error": "Either the tour/site does not exist, or it has no ratings to display."
}
```

###<a name="show-tr"></a>Displaying a Single Rating

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
      "rateable_type": "Site",
}
```

If the request failed, you should receive the status code 404 and ...

```
{
  "error": "Could not find object: Couldn't find Rating with 'id'=#{id}"
}
```

###<a name="create-tr"></a>Creating a New Rating

#### POST `/tours/:id/ratings` (tours)
#### POST `/sites/:id/ratings` (sites)

**Query Params**:

`id`: Integer

**Post Params**:

`score`: Integer (1 <= score <= 5) (required)

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
  "error": "You must enter a valid rating (1 - 5)"
}
```

###<a name="update-tr"></a>Updating an Existing Rating

#### PATCH `/ratings/:id`

**Query Params**:

`id`: Integer

**Post Params**:

`score`: Integer (1 <= score <= 5) (required)

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
  "error": "You are not authorized to modify this rating."
}
```

###<a name="delete-tr"></a>Deleting an Existing Rating

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
{
  "error": "You are not authorized to delete this rating."
}
```

##<a name="review-endpoints"></a>Reviews

###<a name="index-reviews"></a>Displaying an Index of Reviews

#### GET `/tours/:id/reviews`

**Params**:

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "reviews": [
    "review": {
      "id": 3,
      "tagline": "Great tour!",
      "body": "Lots of beautiful dog parks.",
      "tour_id": 7,
  },

    ...
  ]
},
```

If the request failed, you should receive the status code 404 and ...

```
{
  "error": "Either the tour does not exist, or it has no reviews to display."
}
```

###<a name="show-review"></a>Displaying a Single Review

#### GET `/reviews/:id`

**Params**:

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "review": {
    "id": 3,
    "tagline": "Great tour!",
    "body": "Lots of beautiful dog parks.",
    "tour_id": 7,
}
```

If the request failed, you should receive the status code 404 and ...

```
{
  "error": "Could not find object: Couldn't find Review with 'id'=#{id}"
}
```

###<a name="create-review"></a>Creating a New Rating

#### POST `/tours/:id/reviews`

**Query Params**:

`id`: Integer

**Post Params**:

`tagline`: String

`body`: Text (required)

**Response**

If the request was successful, you should receive the status code 201 and ...

```
{
  "review": {
    "id": 3,
    "tagline": "Great tour!",
    "body": "Lots of beautiful dog parks.",
    "tour_id": 7,
  }
}
```

If the request failed, you should receive the status code 401 and ...

```
{
  "error": "You must be authenticated to create a review."
}
```

###<a name="update-review"></a>Updating an Existing Review

#### PATCH `/reviews/:id`

**Query Params**:

`id`: Integer

**Post Params**:

`tagline`: String

`body`: Text

**Response**

If the request was successful, you should receive the status code 202 and ...

```
{
  "review": {
    "id": 3,
    "tagline": "Great tour!",
    "body": "Lots of beautiful dog parks.",
    "tour_id": 7,
  }
}
```

If the request was unsuccessful, you should receive the status code 401 and ...

```
{
  "error": "You are not authorized to modify this review."
}
```

###<a name="delete-review"></a>Deleting an Existing Review

#### DELETE `/reviews/:id`

**Params**

`id`: Integer

**Response**

If the request was successful, you should receive the status code 202 and ...

```
"The review has been deleted successfully."
```

If the request was unsuccessful, you should receive the status code 401 and ...

```
{
  "error": "You are not authorized to delete this review."
}
```

##<a name="user-endpoints"></a>Users

###<a name="tr-user"></a>Displaying a User's Tour Ratings

#### GET `/users/:id/tour_ratings`

**Params**

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "tour_ratings": [
    "rating": {
      "id": 3,
      "tour_id": 6,
      "tour_name": "Marvin Gardens",
      "rating": 5
  },

    ...
  ]
}
```

If the request was unsuccessful, you should receive the status code 204 and ...

```
{
  "error": "The user has no site ratings to display."
}
```

###<a name="sr-user"></a>Displaying a User's Site Ratings

#### GET `/users/:id/site_ratings`

**Params**

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "site_ratings": [
    "rating": {
      "id": 3,
      "site_id": 6,
      "tour_name": "Marvin Gardens",
      "rating": 5
  },

    ...
  ]
}
```

If the request was unsuccessful, you should receive the status code 204 and ...

```
{
  "error": "The user has no site ratings to display."
}
```

###<a name="reviews-user"></a>Displaying a User's Tour Reviews

#### GET `/users/:id/tour_reviews`

**Params**

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "tour_reviews": [
    "review": {
      "id": 3,
      "tagline": "Our favorite tour!",
      "body": "We take this tour twice a day, every day. Love you, Wanderful!",
      "tour_id": 6
  },

    ...
  ]
}
```

If the request was unsuccessful, you should receive the status code 204 and ...

```
{
  "error": "The user has no tour reviews to display."
}
```

###<a name="favorites-user"></a>Displaying a User's Favorite Tours

#### GET `/users/:id/favorites`

**Params**

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "favorites": [
    "favorite": {
      "id": 3,
      "user_id": 6,
      "favoritable_id": 2,
      "favoritable_type": "Tour"
  },

    ...
  ]
}
```

If the request was unsuccessful, you should receive the status code 204 and ...

```
{
  "error": "The user has no favorites to display."
}
```

##<a name="favorite-endpoints"></a>Favorites

###<a name="create-favorite"></a>Creating a New Favorite

#### POST `/favorites`

**Post Params**

`tour_id`: Integer (Note: this param must be sent as a post param) (required)

**Response**

If the request was successful, you should receive the status code 201 and ...

```
{
  "favorite": {
    "id": 3,
    "user_id": 4,
    "favoritable_id": 3,
    "favoritable_type": "Tour"
  }
}
```

If the request was unsuccessful, you should receive the status code 401 and ...

```
{
  "error": "You must be authenticated to favorite a tour."
}
```

###<a name="delete-favorite"></a>Deleting an Existing Favorite

#### DELETE `/favorites/:id`

**Query Params**

`id`: Integer

**Response**

If the request was successful, you should receive the status code 202 and ...

```
"The favorite was deleted successfully."
```

If the request was unsuccessful, you should receive the status code 401 and ...

```
{
  "error": "Either the favorite does not exist, or you are not authorized to delete it."
}
```