# Winstars
This is a iOS project

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

## Getting the Project
1. git clone or download the project
2. open the terminal and `cd` to the project e.g`cd ../Desktop/Winstars`
3. `pod install` to download the dependencies, if failed to run command , make sure you have installed [cocoapods](https://cocoapods.org/)
4. Open the `Winstars.xcworkspace`



## Something you should do after opening the project
1. Remember to add/change API in \ViewController\VIdeo\DistrictViewController.swift
 - Refer to this [YouTube Data API Overview](https://developers.google.com/youtube/v3/getting-started)
2. Remeber to do initial set up for firebase
- Refer to [Firebase Console](https://console.firebase.google.com/ )
- Replace GoogleService-info.plist
- enable Annoyomous authentication
  
3. Enable Cloud FireStore
- Add a collection name "groups"
- Add five documents under "groups" collection with the following fields
- The documentID does not matter, you may use Auto-ID
- For each documentID under "groups",
- each item should have an auto-genereted ID,

1st Document, 
- Field: listNum, Type: number, Value: 0
- Field: name, Type: string, value: "Science"

2nd Document, 
- Field: listNum, Type: number, Value: 1
- Field: name, Type: string, value: "Technology"

3rd Document, 
- Field: listNum, Type: number, Value: 2
- Field: name, Type: string, value: "Engineering"

4th Document, 
- Field: listNum, Type: number, Value: 3
- Field: name, Type: string, value: "Mathematics"

5th Document, 
- Field: listNum, Type: number, Value: 4
- Field: name, Type: string, value: "Coding"
