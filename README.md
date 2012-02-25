Snitch
======

Mini identity server that queries your router to find out who's in the office

[![Build Status](https://secure.travis-ci.org/martinisoft/snitch.png?branch=master)](http://travis-ci.org/martinisoft/snitch)

How does it work?
-----------------

This app uses SNMP to query your AirportExtreme for active DHCP Clients and
returns ther MAC addresses via a web URL.

Most Apple routers have **4 hours** as the default DHCP lease timeout. Depending on the size of your office network. You may want to set the lease timeout to around **10 minutes** to give a much more accurate response.

What's it for?
--------------

This was mainly built to support the [play](https://github.com/holman/play) app by Zach Holman.
It's also used in the [Hashrocket Chicago](http://www.hashrocket.com/) office to
supply who's in the office to our [Hubot](https://github.com/github/hubot).

How do I shot web?
------------------

```
$ bundle
```

Make a copy of snitch.example.yml and rename it

```
cp snitch.example.yml snitch.yml
```

Edit the snitch.yml, update router_name and list out the MAC address and
github/username of each user you want to track.

```
router_name: andromeda.local
"23:98:72:27:2E:88": martinisoft
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

Requirements
------------

* Ruby 1.9.x (This app comes with an rvmrc for 1.9.3-p0)
* Airport Extreme/Express router that has SNMP Enabled

BONUS ROUND!
------------

Want to teach hubot how to talk to snitch? Load the snitch.coffee module into
[Hubot](https://github.com/github/hubot). Make sure you also load the
github-credentials.coffee module from github-scripts, because it matches
names from there.
