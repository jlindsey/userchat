---
layout: default
title: Userchat – Database
---

[<< Home](index.html)

Users
-----
Need to look up omniauth db schemas

* email
* username
* password\_hash
* password\_salt
* site\_id

Roles
-----
Can-can lookup

Permissions
-----------
Can-can lookup

Sites
-----
The different sites that have signed up. Users and chats both belong to sites (except super users).
The API key is used in the javascript embed.

* name
* url
* description
* api\_key

ChatLogs
--------
The live chats are handled in redis. After chats are complete, the transcript is logged to the
database for persistance. Some kind of formatting should happen on the `transcript` field,
or it should be stored possibly as serialized JSON.

The `chat_url` field is the exact page the client user was on when they initiated the chat.

The `rating` field is the rating the user gave the chat. Ratings can be customized per Site.

* chat\_datetime
* user\_id
* site\_id
* chat\_url
* transcript
* rating

Settings
--------
Settings that each site can customize.

This is a key-value store, but I'm on the fence about.

* site\_id
* name
* value

