module.exports = socials =
  targets: ['开心网','人人网','chinaren','新浪微博','腾讯微博','百度空间','5460同学录']
  category: 'social'
  cid: '2'
  name: '社交网络'
  rules:[
    '手机、邮箱'
    '手机、邮箱'
    '邮箱'
    '手机、邮箱'
    '用户ID(6~20位，由字母、数字、下划线或减号构成)'
    '邮箱'
    '邮箱'
  ]
  agent: ''
  urls:[
    "http://www.kaixin001.com/"
    "http://www.renren.com/"
    "http://class.chinaren.com/index.jsp"
    "http://weibo.com/"
    "http://t.qq.com/login.php"
    "http://hi.baidu.com/"
    "http://sns.5460.net/"
  ]
  validate_urls: {
    email:
      "http://reg.kaixin001.com/interface/checkemail.php?email=#{name}"
      "http://reg.renren.com/AjaxRegisterAuth.do?authType=email&value=#{name}"
      "http://class.chinaren.com/a/passport/checkuser.do?passport=#{name}"
      "http://weibo.com/signup/v5/formcheck?type=email&value=#{name}"
      ""
      "https://passport.baidu.com/v2/?regmailcheck&token=b959992e7171c26510acf1db7572696b&tpl=qing&apiver=v3&tt=1376224080016&email=#{name}&callback=bd__cbs__woibgk"
      "http://sns.5460.net/pages/Register/auth/zhuce!zhuce.action?email=#{name}"
    tel:
      "http://reg.kaixin001.com/interface/checknickname.php?rg=mobile&nickname=#{name}"
      "http://reg.renren.com/AjaxRegisterAuth.do?authType=email&stage=3&value=#{name}"
      ""
      "http://weibo.com/signup/v5/formcheck?type=mobilesea&zone=0086&value=#{name}"
      ""
      ""
    name:
      ""
      ""
      ""
      ""
      "http://api.t.qq.com/old/checkAccount.php?type=emailreg&account=#{name}"
      ""
      ""
  }
  referer: [
    ""
    ""
    ""
    "http://weibo.com/signup/signup.php?ps=u3&lang=zh"
    "http://zc.qq.com/iframe/12/reg.html"
    ""
  ]
  format: [
    undefined
    undefined
    undefined
    undefined
    {

      regex: /^[a-zA-Z][a-zA-Z0-9_\-]*$/
      min: 6
      max: 20
    }
    undefined
    undefined
  ]
  check: [
    (i, name, cb)->
      request.get url, (e, r, data)->
        return cb data == '0'

    (i, name, cb)->
      request.post url, (e, r, data)->
        return cb data == 'OK'

    (i, name, cb)->
      return cb 'invalid' if !isEmail name
      url = validate_urls.email[2]
      request.get url, (e, r, data)->
        objdata = parseJson(data)
        if objdata and objdata.data and objdata.data.status
          return cb objdata.data.status == '0'
        return cb 'invalid'

    (i, name, cb)->
      if isTel name
        url = validate_urls.email[3]
      else if isEmail name
        url = validate_urls.tel[3]
      else
        return cb 'invalid'
      request.get
        url: url
        headers:
          Referer: Referer[3]
      , (e, r, data)->
        objdata = parseJson(data)
        if objdata and objdata.type
          return cb objdata.data.type == 'ok'
        return cb 'invalid'

    (i, name, cb)->
      if !formatValidation name, format.regex[4], format.max, format.min
        return cb 'invalid'
      request
        url: validate_urls.name[4]
        headers:
          Referer: Referer[4]
      ,(e, r, data)->
        return cb data.indexOf('Available') != -1

    (i, name, cb)->
      return cb 'invalid' if !isEmail name
      request.get validate_urls.email[5], (e,r,data)->
        return cb data.indexOf('"no": "0"') != -1

    (i, name, cb)->
      return cb 'invalid' if !isEmail name
      request.get validate_urls.email[5], (e, r, data)->
        return cb data == '邮箱可用'
  ]
