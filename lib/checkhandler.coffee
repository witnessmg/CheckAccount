# access corresponding config file in models folder when router calls once request comes in
# handle validation of certain account for certain websites
# return result

# Model dependencies

email = require './models/emails'
extra = require './models/extras'
social = require './models/socials'
forum = require './models/forums'
appointment = require './models/appointment'
discuz =require './models/discuz'

emailExistence = require './mx_email-existence'

categories = [email, extra, social, forum, appointment, discuz]

module.exports = checkhandle =
  checktype: (id, name, cb) ->
    cid = Math.floor id / 100   # group id
    mid = id % 100              # member id
    if categories[cid].validate_urls.email[mid] && isEmail name
      if cid === 0
        mx_email_check cid, mid, name, cb
      else
        email_check cid, mid, name, cb
    else if categories[cid].validate_urls.tel[mid] && isTel name
        tel_check cid, mid, name, cb
    else if categories[cid].validate_urls.name[mid] && categories[id].format
      it =categories[id].format
      if !formatValidation name, it.regex, it.max, it.min
        return cb 'invalid'
      name_check cid, mid, name, cb
    else
      return cb 'invalid'

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

mx_email_check = (cid, mid, name, cb) ->

email_check = (cid, mid, name, cb) ->
  url = categories[cid].validate_urls.email[mid]

tel_check = (cid, mid, name, cb) ->
  url = categories[cid].validate_urls.tel[mid]

name_check = (cid, mid, name, cb) ->
  url = categories[cid].validate_urls.name[mid]
