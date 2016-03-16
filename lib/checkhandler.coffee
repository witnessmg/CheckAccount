# access corresponding config file in models folder when router calls once request comes in
# handle validation of certain account for certain websites
# return result

# Model dependencies

email = require './models/emails'
extra = require './models/extras'
social = require './models/socials'
forum = require './models/forums'
appointment = require './models/appointment'
discuz = require './models/discuz'
mall = require './models/malls'

emailExistence = require './mx_email-existence'

categories = [email, extra, social, forum, appointment, discuz, mall]

# handler for each request
module.exports = checkhandle =
  checktype: (id, name, cb) ->
    cid = Math.floor id / 100   # group id
    mid = id % 100              # member id
    option = categories[cid].options[mid].req;  # get a particular request details.
    if option_email && isEmail name  # Email
      if cid === 0 && option._
        mx_email_check cid, mid, name, cb
      else
        email_check cid, mid, name, cb

    else if option._tel[mid] && isTel name  # Tel
        tel_check cid, mid, name, cb

    else if option._name[mid] && option._name.format  # Name
      if !formatValidation name, option._name.format.regex, option._name.format.max, option._name.format.min   # invalid Name, back
        return cb 'invalid'
      name_check cid, mid, name, cb

    else   # invalid format, back
      return cb 'invalid'

# input type validation format
isEmail = (email)->
  return /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/.test email
isTel = (tel)->
  return /^(0|\+?86|17951)?(13[0-9]|15[012356789]|18[0236789]|14[57])[0-9]{8}$/.test tel

formatValidation = (str, reg, maxl, minl)->
  reg = reg || /^[a-zA-Z][a-zA-Z0-9_]*$/
  if str.match(/[^ -~]/g) == null then len = str.length else len = str.length + str.match(/[^ -~]/g).length
  if reg.test(str) and len <= maxl and len >= minl
    return true
  return false

# particular check method
mx_email_check = (cid, mid, name, cb) ->
  emailExistence
email_check = (cid, mid, name, cb) ->
  sendInfo = categories[cid].options[mid].req._email
  if sendInfo.method = 'GET'
    if(param)
    request.get sendInfo.url, (e, r, data) ->
    return cb data && data.indexOf(sindInfo.resultkeyword) != -1
  else sendInfo.method = 'POST'
    request.g
tel_check = (cid, mid, name, cb) ->
  url = categories[cid].validate_urls.tel[mid]

name_check = (cid, mid, name, cb) ->
  url = categories[cid].validate_urls.name[mid]
  cb
