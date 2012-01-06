Snitch
======

Mini identity server that queries your router to find out who's in the office

How does it work?
-----------------

This app uses SNMP to query your AirportExtreme for active DHCP Clients and
returns ther MAC addresses via a web URL.

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
