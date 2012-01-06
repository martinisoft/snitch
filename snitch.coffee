# Snitch adapter, displays people in the office
# Need snitch? https://github.com/martinisoft/snitch
#
# who's in the office - List everyone in the office
module.exports = (robot) ->
  robot.respond /who's in the office/i, (msg) ->
    theReply = "Here is who I see:\n"
    msg.http("http://localhost:9292/who")
      .get() (err, res, body) ->
        switch res.statusCode
          when 200
            people = body.split(",")
            for person in people
              for own key, user of robot.brain.data.users
                if (user.githubLogin == person)
                  theReply += user.name + "\n"

            msg.send theReply
          else
            msg.send "Unable to ask snitch, is it dead?"
