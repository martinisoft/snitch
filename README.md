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

Edit the constant at the top of the snmp.rb file to match the
Bonjour Name/IP if your AP Extreme/Express

```
ROUTER_NAME='andromeda.local'
```

_Make sure SNMP is enabled on your AP Extreme/Express_

Boot the server

```
ruby snmp.rb
```

Curl away!

```
curl http://localhost:8888/who
```

Requirements
------------

* Ruby 1.9.x (This app comes with an rvmrc for 1.9.3-p0)
* Airport Extreme/Express router that has SNMP Enabled
