https://github.com/akaneedwards/CS-1998-Anime-News-App
https://animenewsapp.herokuapp.com/
third party API used: https://www.animenewsnetwork.com/encyclopedia/api.php

database models:
Anime
User
association_table_favs

EXTRA THINGS TO NOTE:
For this hack challenge we read the data from the third party API via webscraping and parsing XML files.
As a result the majority of the work in the backend involved learning how to do webscraping, in addition
to learning how to parse XML files to be usable in a JSON format. Because API requests to the
animenewsnetwork API respond in an XML format an XML file of the response must be saved in order to 
parse it, resulting in each subsequent request to the animenewsnetwork API needing to create another XML
file. To avoid making an excessive amount of XML files, the app only requests for the first 50 titles
listed on animenewsnetwork's API.

-- ROUTES --
Get first 50 animes of animenewsnetwork's anime database
GET "/api/animes/"
Response
{
    "success": true,
    "data": [
        {
            "id": 1,
            "name": "Anime title",
            "description": "Anime description",
            "fans": [ <SERIALIZED USER>, ... ]
        },
        {
            "id": 2,
            "name": "Anime title 2",
            "description": "Anime description 2",
            "fans": [ <SERIALIZED USER>, ... ]
        }
        ...
    ]
}

Create an anime
POST "/api/animes/"
Request
{
    "name": <USER INPUT>,
    "description": <USER INPUT>
}

Response
{
    "success": true,
    "data": {            
        "id": <ID>,
        "name": <USER INPUT FOR NAME>,
        "description": <USER INPUT FOR DESCRIPTION>,
        "fans": []
    }
}

Get a specific anime
GET "api/animes/{id}/"
Response
{
    "success": true,
    "data": {            
        "id": <ID>,
        "name": "Anime title",
        "description": "Anime description",
        "fans": [ <SERIALIZED USER>, ... ]
    }
}

Get a specific anime by name
GET "api/animes/name/{name}/"
Response
{
    "success": true,
    "data": {            
        "id": <ID>,
        "name": "Anime title",
        "description": "Anime description",
        "fans": [ <SERIALIZED USER>, ... ]
    }
}

Delete a specific anime
DELETE "api/animes/{id}/"
Response
{
    "success": true,
    "data": {            
        "id": <ID>,
        "name": "Anime title",
        "description": "Anime description",
        "fans": [ <SERIALIZED USER>, ... ]
    }
}

Delete a specific anime by name
DELETE "api/animes/name/{name}/"
Response
{
    "success": true,
    "data": {            
        "id": <ID>,
        "name": "Anime title",
        "description": "Anime description",
        "fans": [ <SERIALIZED USER>, ... ]
    }
}

Create a user
POST "/api/users/"
Request
{
    "username": <USER INPUT>
}

Response
{
    "success": true,
    "data": {
        "id": <ID>,
        "username": <USER INPUT FOR USERNAME>,
        "favorites": []
    }
}

Get a specific user
GET "/api/users/{id}/"
Response
{
    "success": true,
    "data": {
        "id": <ID>,
        "username": <USER INPUT FOR USERNAME>,
        "favorites": []
    }
}

Add an anime to a user's favorites
POST "/api/users/{id}/add/"
Request
{
    "anime_id": <USER INPUT>
}

Response
{
    "success": true,
    "data": <SERIALIZED ANIME>
}