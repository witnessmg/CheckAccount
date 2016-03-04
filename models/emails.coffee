module.exports = emails =
  cid:
  targets: ['163邮箱','126邮箱','网易yeah邮箱', 'Google邮箱','搜狐邮箱','tom邮箱','搜狗邮箱','21CN邮箱','188财富邮箱','新浪邮箱(.com)', '新浪邮箱(.cn)']
  category: 'email'
  name: '邮箱'
  desc: '若待检测的为邮箱帐号，则该项只检测"@"之前的用户名'
  rules: [
    '手机号或6~18个字符，可使用字母、数字、下划线，需以字母开头'
    '手机号或6~18个字符，可使用字母、数字、下划线，需以字母开头'
    '手机号或6~18个字符，可使用字母、数字、下划线，需以字母开头'
    '6~30个字符，可实用字母、数字、点'
    '6-18个字符，仅支持字母、数字及“.”、”-”、”_”，不能全部数字或下划线'
    '4-16位，数字、小写字母、点、减号或下划线，小写字母开头'
    '手机号或4~16个字符、包括字母、数字、下划线、中划线，字母开头，非特殊字符结尾，不区分大小写'
    '5至20个英文字母、数字、点、减号或下划线组成'
    ''
    '4-16位，数字、小写字母、下划线，下划线不能在首尾'
    '4-16位，数字、小写字母、点、减号或下划线，小写字母开头'
  ]
  urls: [
    "http://mail.163.com/"
    "http://mail.126.com/"
    "http://www.yeah.net/"
    "https://mail.google.com/"
    "http://mail.sohu.com/"
    "http://web.mail.tom.com/webmail/login/index.action"
    "http://mail.sogou.com/"
    "http://mail.21cn.com/"
    "http://188.com/"
    "http://mail.sina.com.cn/"
    "http://mail.sina.com.cn/"
  ]
  check:[
    (name, cb) ->
      name=name.split('@')[0]
      name += '@163.com'
      emailExistence.check name, (err,res)->
        return cb !res
    (name, cb) ->
      name=name.split('@')[0]
      name += '@126.com'
      emailExistence.check name, (err,res)->
        return cb !res
    (name, cb) ->
      name=name.split('@')[0]
      name += '@yeah.net'
      emailExistence.check name, (err,res)->
        return cb !res
    (name, cb) ->
      name=name.split('@')[0]
      name += '@gmail.com'
      return cb 'invalid'
    (name, cb) ->
      if !formatValidation name, /^[a-zA-Z][a-zA-Z0-9_\-\.]*$/, 16, 4
        return cb 'invalid'
      request.get "http://passport.sohu.com/jsonajax/checkusername.action?domain=sohu.com&appid=1000&mobileReg=false&shortname=#{name}", (e, r, data)->
        objdata = parseJson(data)
        if objdata and objdata.status
          status = objdata.status
          return cb status == '0'
      return cb 'invalid'
    (name, cb) ->
      if !formatValidation name, /^[a-zA-Z0-9_\-\.]*$/, 18, 6
        return cb 'invalid'
      request.get "http://web.mail.tom.com/webmail/register/checkname.action?userName=#{name}", (e, r, data)->
        objdata = parseJson(data)
        if objdata and objdata.isUserNameExist
          return cb objdata.isUserNameExist
      return cb 'invalid'
    (name, cb) ->
      request.get "https://account.sogou.com/web/account/checkusername?username=#{name}", (e, r, data)->
        objdata = parseJson(data)
        if objdata and objdata.status
          return cb objdata.status == "0"
        return cb 'invalid'
      return
    (name, cb) ->
      name=name.split('@')[0]
      name += '@21cn.com'
      emailExistence.check name, (err,res)->
        return cb !res
    (name, cb) ->
      name=name.split('@')[0]
      name += '@188.com'
      emailExistence.check name, (err,res)->
        return cb !res
    (name, cb) ->
      return cb 'invalid' unless formatValidation name, /^[a-z0-9][a-z0-9_]*[a-z0-9]$/, 16, 6
      request.post (url: "https://mail.sina.com.cn/register/chkmail.php", strictSSL: false, form: (mail: "#{name}@sina.com", ts: Date.now())), (e, r, data)->
        objdata = parseJson data
        if objdata and objdata.result
          return cb objdata.result
        return cb 'invalid'
      return
    (name, cb) ->
      return cb 'invalid' unless formatValidation name, /^[a-z0-9][a-z0-9_]*[a-z0-9]$/, 16, 6
      request.post (url: "https://mail.sina.com.cn/register/chkmail.php", strictSSL: false, form: (mail: "#{name}@sina.cn", ts: Date.now())), (e, r, data)->
        objdata = parseJson data
        if objdata and objdata.result
          return cb objdata.result
        return cb 'invalid'
      return
  ]
