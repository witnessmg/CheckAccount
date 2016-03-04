dns = require("dns")
net = require("net")
module.exports = (email, callback, timeout) ->
  timeout = timeout or 10000
  unless /^\S+@\S+$/.test(email)
    callback null, false
    return
  dns.resolveMx email.split("@")[1], (err, addresses) ->
    if err or addresses.length is 0
      callback err, false
      return
    address = addresses[0]
    addresses.forEach (ele, index) ->
      address = ele  if ele.priority < address.priority

    conn = net.createConnection(25, address.exchange)
    commands = [ "HELO verify-email.org", "MAIL FROM: <check@verify-email.org>", "RCPT TO: <" + email + ">" ]
    i = 0
    conn.setEncoding "ascii"
    conn.setTimeout timeout
    conn.on "error", ->
      conn.emit "false"

    conn.on "false", ->
      callback err, false
      conn.removeAllListeners()

    conn.on "connect", ->
      conn.on "prompt", ->
        if i < 3
          conn.write commands[i]
          conn.write "\n"
          i++
        else
          callback err, true
          conn.removeAllListeners()

      conn.on "undetermined", ->

        #in case of an unrecognisable response tell the callback we're not sure
        callback err, false, true
        conn.removeAllListeners()

      conn.on "timeout", ->
        conn.emit "undetermined"

      conn.on "data", (data) ->
        if data.indexOf("220") isnt -1 or data.indexOf("250") isnt -1
          conn.emit "prompt"
        else unless data.indexOf("550") is -1
          conn.emit "false"
        else
          conn.emit "undetermined"



# compatibility
module.exports.check = module.exports
