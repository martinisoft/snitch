Snitch
======

Mini identity server that queries your router to find out who's in the office

[![Build Status](https://secure.travis-ci.org/martinisoft/snitch.png?branch=master)](http://travis-ci.org/martinisoft/snitch)

Requirements
------------

* Ruby 2.0.0 (This app comes with a ruby-version and ruby-gemset just in case)
* Airport Extreme/Express router that has SNMP Enabled

What is it for?
---------------

This was mainly built to support the original [play](https://github.com/play/play) app by [Zach Holman](https://github.com/holman) where
it was used to automatically queue favorite songs based on someone's presence
in the office.
You can also hook snitch up to your [Hubot](https://github.com/github/hubot) to see who is in the office.

### How does it work?

This app uses SNMP to query your AirportExtreme for active DHCP Clients and
returns ther MAC addresses via a web URL.

##### Special note about router configuration

Most Apple routers have **4 hours** as the default DHCP lease timeout.
Depending on the size of your office network. You may want to set the
lease timeout to around **10 minutes** to give a much more accurate response.

Getting started
---------------

First, setup your bundle

```
$ bundle
```

Make a copy of snitch.example.yml and rename it

```
cp snitch.example.yml snitch.yml
```

Edit the snitch.yml, update router\_name and list out the MAC addresses
(in lowercase) and github account/username of each user you want to track.

```
router_name: hal.local
"23:98:72:27:2e:88": martinisoft
```

_Make sure SNMP is enabled on your AP Extreme/Express_

Boot the server

```
rackup
```

Curl away!

```
curl http://localhost:9292/who
```

It should return a comma-delimited list of usernames, compatible with [play](https://github.com/holman/play)

Hubot Script (optional)
-----------------------

Want to teach hubot how to talk to snitch? Load the snitch.coffee module into
[Hubot](https://github.com/github/hubot). Make sure you also load the
github-credentials.coffee module from github-scripts, because it matches
names from there.

License and Author
------------------

Copyright (C) 2012-2013 Aaron Kalin

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
