module.exports = appointments =
  targets: ['世纪佳缘', '百合网', '珍爱网', '嫁我网', '红娘网', '爱情公寓', '知己网', '绝对100婚恋网', '江南情缘']
  name: '约会'
  category: 'appointment'
  cid: 4
  rules: [
    '手机、邮箱'
    '手机、邮箱'
    '手机'
    '邮箱'
    '手机、邮箱'
    '邮箱、用户名(3-16个小写英文字母或数字组成)'
    '用户名(20位以内中英文数字，不能为纯数字)'
    '邮箱'
    '邮箱'
  ]
  urls: [
    "http://login.jiayuan.com/"
    "http://passport.baihe.com/login.jsp"
    "http://album.zhenai.com/login/login.jsp"
    "http://www.marry5.com/"
    "http://7651.com/login/enter.html"
    "http://pps.ipart.cn/signup.php"
    "http://www.zhiji.com/"
    "http://www.juedui100.com/"
    "http://www.88999.com/login/Login.aspx"
  ]
  validate_urls: {
    email:[
      "http://reg.jiayuan.com/libs/xajax/reguser.server.php?processTraceUser"
      "http://love.baihe.com/EmailCheckForXs.action?email=#{name}"
      ""
      "http://www.marry5.com/sso/CheckEmail?email=#{name}"
      "http://7651.com/site/ajaxcheckname?username=#{name}"
      "http://www.ipart.cn/register_new/register_response_final.php"
      ""
      "http://www.juedui100.com/ajax/identifyEmail?email=#{name}"
      "http://www.88999.com/Register/checkExistAction.aspx?email=#{name}"
    ]
    tel:[
      "http://reg.jiayuan.com/libs/xajax/reguser.server.php?processUserMobile"
      "http://love.baihe.com/EmailCheckForXs.action?email=#{name}"
      "http://album.zhenai.com/register/validateMobile3.jsps?mobile=#{name}"
      ""
      "http://7651.com/site/cktel"
      ""
      ""
      ""
      ""
    ]
    name:[
      ""
      ""
      ""
      ""
      ""
      "http://www.ipart.cn/register_new/register_response_final.php"
      "http://www.zhiji.com/ajax.asp?checksubmit=yes"
      ""
      ""
    ]
  }
  format: [
    undefined
    undefined
    undefined
    undefined
    undefined
    {
      regex: /^[a-z0-9]*$/
      max: 16
      min: 3
    }
    {
      regex: /^[a-zA-Z0-9]*[a-zA-Z]+[a-zA-Z0-9]*$/
      max: 20
      min: 1
    }
    undefined
    undefined
  ]
  check: [
    (name, cb) ->
      url_base = validate_urls_base[0]
      if isEmail name
        url = '#{url_base}?processTraceUser'
        form =
          'xajax': 'processTraceUser'
          'xajaxargs[]': "<xjxquery><q>email=#{name}</q></xjxquery>"
          'xajaxargs[]': 'email'
      else if isTel name
        url = '#{url_base}?processUserMobile'
        form =
          'xajax': 'processUserMobile'
          'xajaxargs[]': "<xjxquery><q>mobile=#{name}</q></xjxquery>"
      else
        return cb 'invalid'
      request.post
        url: url
        form: form
      , (e, r, body)->
        return cb body.indexOf('exactness') != -1
    (name, cb) ->
      return cb 'invalid' if !isEmail(name) and !isTel name
      url_base = validate_urls_base[1]
      url = "#{url_base}?email=#{name}"
      request.get url, (e, r, body)->
        return cb body.indexOf('"1"') != -1
    (name, cb) ->
      return cb 'invalid' if !isTel name
      url_base = validate_urls_base[2]
      request.get "#{url_base}?mobile=#{name}", (e, r, body)->
        return cb body == 'yes'
    (name, cb) ->
      return cb 'invalid' if !isEmail name
      url_base = validate_urls_base[3]
      request.get "#{url_base}?email=#{name}", (e, r, body)->
        return cb body == '0'
    (name, cb) ->
      url_base = validate_urls_base[4]
      if isEmail name
        request.get "#{url_base}/ajaxcheckname?username=#{name}", (e, r ,body)->
          return cb body == '1'
      else if isTel name
        request.post
          url: "#{url_base}/cktel"
          form:
            telphone: name
        , (e, r, body)->
          return cb body == ''
      else
        return cb 'invalid'
    (name, cb) ->
      if isEmail name
        form = param: "{'action':'validate_email','email':'#{name}'}"
      else
        return cb 'invalid' if !formatValidation name, /^[a-z0-9]*$/, 16, 3
        form = param: "{'action':'validate_id','userid':'#{name}'}"

      request.post
        url: validate_urls_base[5]
        form: form
      ,(e, r, body)->
        return cb body == '0'
    (name, cb) ->
      return cb 'invalid' if !formatValidation name, /^[a-zA-Z0-9]*[a-zA-Z]+[a-zA-Z0-9]*$/, 20, 1
      request.post
        url: validate_urls_base[6]
        form:
          action:'checkusername_lay'
          username: name
      ,(e, r, body)->
        return cb body.indexOf('//window.parent.document.getElementById("Regbtn").disabled=false;') != -1
    (name, cb) ->
      return cb 'invalid' if !isEmail name
      request.get "#{validate_urls_base[7]}?email=#{name}", (e, r, body)->
        return cb body == '0'
    (name, cb) ->
      return cb 'invalid' if !isEmail name
      request.get "#{validate_urls_base[8]}?email=#{name}", (e, r, body)->
        return cb body == '0'
  ]
