# Winstars

## Requirement 

## Mobile App Development
In this project, since setting up a backend server from scratch (server, api doc, query) is so tedious and time consuming, **'Cloud FireStore@Google Firebase'** (Backend-as-a-Service)  will be used.

### Cloud FireStore
- NoSQL, document-oriented database
- no tables and rows
- Store data in *documents*, which organized into *collections*

### Documents
-   a set of key-value pairs
-  must be stored in collections
- can contain subcollections and nested objects,


### Before start
1.   Remember to add/change API in \ViewController\VIdeo\DistrictViewController.swift
 - Refer to this [YouTube Data API Overview](https://developers.google.com/youtube/v3/getting-started)
2. Remeber to do initial set up for firebase
- Refer to [Firebase Console](https://console.firebase.google.com/ )
- Replace GoogleService-info.plist
- enable Annoyomous authentication
  
3. Enable Cloud FireStore
- Add a collection name "groups"
- Add five documents under "groups" collection with the following fields
- The documentID does not matter, you may use Auto-ID

|  Field |Type   | Value|
|---|---|---|
| listNum  | number  | 1 |
|name |String | Science|

|  Field |Type   | Value|
|---|---|---|
| listNum  | number  | 1 |
|name |String | Science|
|  Field |Type   | Value|
|---|---|---|
| listNum  | number  | 1 |
|name |String | Science|
|  Field |Type   | Value|
|---|---|---|
| listNum  | number  | 1 |
|name |String | Science|
|  Field |Type   | Value|
|---|---|---|
| listNum  | number  | 1 |
|name |String | Science|