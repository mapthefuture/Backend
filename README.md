## Map The Future

A crowdsourced touring app that offers new, fresh perspectives on the city to locals and travelers alike!

## API

**Production Base URI**: https://fathomless-savannah-6575.herokuapp.com

Append endpoints to base uri.

**Authentication Notes**:

Authentication not yet implemented


### Displaying an Index of Tours

#### GET `/tours`

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "tours": [
    {
      "id": 1,
      "user_id": 2,
      "title": "Historical Views",
      "length": "4 hours"
    },

    ...
  ]
}
```

If the request failed, you should receive the status code 404 and ...

```
{
  "error": "Could not find object: Couldn't find Tour with 'id'='all'"
}
```

### Displaying a Single Tour

#### GET `/tours/:id`

**Query Params:**

`id`: Integer

**Response**

If the request was successful, you should receive the status code 200 and ...

```
{
  "tour": {
    "id": 1,
    "user_id": 2,
    "title": "Historical Views",
    "length": "4 hours"
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

**Post Params:**

`title`: String

`length`: String

**Response**

If the request was successful, you should receive the status code 201 and ...

```
{
  "tour": {
    "id": 1,
    "user_id": 2,
    "title": "Historical Views",
    "length": "4 hours"
  }
}
```

If the request failed, you should receive the status code 422 and ...

```
{
  error: "The tour could not be created."
}
```