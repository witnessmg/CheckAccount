request = require 'request'
emailExistence = require './mx_email-existence'

parseJson = (data)->
  try
    objdata = JSON.parse(data)
    return objdata
  catch error
    console.log "parse json error:",error
    return null


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

email =
  targets: ['163邮箱','126邮箱','网易yeah邮箱', 'Google邮箱','搜狐邮箱','tom邮箱','搜狗邮箱','21CN邮箱','188财富邮箱','新浪邮箱(.com)', '新浪邮箱(.cn)']
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
  category: 'email'
  name: '邮箱'
  desc: '若待检测的为邮箱帐号，则该项只检测"@"之前的用户名'
  check: (i, name, cb)->
    name=name.split('@')[0]
    switch i
      when 0
        name += '@163.com'
      when 1
        name += '@126.com'
      when 2
        name += '@yeah.net'
      when 3
        name += '@gmail.com'
        # this line added by super,because the gmail always can't open
        return cb 'invalid'
      when 4
        if !formatValidation name, /^[a-zA-Z][a-zA-Z0-9_\-\.]*$/, 16, 4
          return cb 'invalid'
        request.post "http://passport.sohu.com/signup/check_email", form: {email: "#{name}@sohu.com"}, (e, r, data) ->
          return cb (data.indexOf '0') != -1
      when 5
        if !formatValidation name, /^[a-zA-Z0-9_\-\.]*$/, 18, 6
          return cb 'invalid'
        request.get "http://web.mail.tom.com/webmail/register/checkname.action?userName=#{name}", (e, r, data)->
          return cb (data.indexOf 'true') != -1
      when 6
        #return cb 'invalid' if !isTel(name) && !formatValidation name, /^[a-z][a-zA-Z0-9_]*$/
        request.get "https://account.sogou.com/web/account/checkusername?username=#{name}", (e, r, data)->
          objdata = parseJson(data)
          if objdata and objdata.status
            return cb objdata.status == "0"
          return cb 'invalid'
        return
      when 7
        name += '@21cn.com'
      when 8
        name += '@188.com'
      when 9
        return cb 'invalid' unless formatValidation name, /^[a-z0-9][a-z0-9_]*[a-z0-9]$/, 16, 6
        request.post (url: "https://mail.sina.com.cn/register/chkmail.php", strictSSL: false, form: (mail: "#{name}@sina.com", ts: Date.now())), (e, r, data)->
          objdata = parseJson data
          if objdata and objdata.result
            return cb objdata.result
          return cb 'invalid'
        return
      when 10
        return cb 'invalid' unless formatValidation name, /^[a-z0-9][a-z0-9_]*[a-z0-9]$/, 16, 6
        request.post (url: "https://mail.sina.com.cn/register/chkmail.php", strictSSL: false, form: (mail: "#{name}@sina.cn", ts: Date.now())), (e, r, data)->
          objdata = parseJson data
          if objdata and objdata.result
            return cb objdata.result
          return cb 'invalid'
        return

    emailExistence.check name, (err,res)->
      return cb !res


extra =
  targets: ['芒果网', '优酷', '精品网', '58团购']
  category: 'extra'
  rules: [
    '手机、邮箱、用户ID(6~12位，字母或数字)'
    '手机、邮箱、昵称(2个中文或4个字符)'
    '邮箱、用户ID(字母开头，5~12位，由英文，数字，"－"，"_"构成)'
    '邮箱、用户名(4~20位，由汉字、数字、字母和"_"组成)'
  ]
  urls:[
    "http://www.mangocity.com/mbrweb/login/init.action"
    "http://www.youku.com/user_login/"
    "http://my.sg.com.cn/"
    "http://passport.58.com/login"
  ]
  name: '其他'
  check: (i, name, cb)->
    switch i
      when 0
        url = "http://www.mangocity.com/mbrweb/validate/validateVerifyCode.action?verifyCode=0297"
        if isTel name
          url = "#{url}&mobileNo=#{name}"
        else if isEmail name
          url = "#{url}"
        else
          if !formatValidation name, /^[a-zA-Z0-9]*$/, 12, 6
            return cb 'invalid'
          url = "#{url}&webId=#{name}"

        request.post url, (e, r, data)->
          return cb data == 'Y'
      when 1
        if isTel name
          url = "http://www.youku.com/user/chkAccount?__rt=1&__ro=&inputs=#{name}"
        else if isEmail name
          url = "http://www.youku.com/user/chk_mail?__rt=1&__ro=&key=email&vo=#{name}"
        else
          if !formatValidation name, /^[\u4E00-\u9FFFa-zA-Z0-9_\-]*$/, 30, 4
            return cb 'invalid'
          url = "http://www.youku.com/user/chk/?__rt=1&__ro=&key=username&vo=#{name}"
        request.get url, (e, r, data)->
          return cb data == '1'
      when 2
        url = "http://reg.sg.com.cn/action.php?ac=check_unique&type=users_name&value=#{name}"
        if isEmail name
          url = "http://reg.sg.com.cn/action.php?ac=check_unique&type=users_email&value=#{name}"
        else if !formatValidation name, /^[a-zA-Z][a-zA-Z0-9\-_]*$/, 12, 5
          return cb 'invalid'
        request.get url, (e, r, data)->
          return cb data != '1'
      when 3
        url = "http://passport.58.com/ajax/checknickname?id=8669&nickname=#{name}"
        if isEmail name
          url = "http://passport.58.com/ajax/checkemail?id=421&email=#{name}"
        else
          if !formatValidation name, /^[\u4E00-\u9FFFa-zA-Z0-9_]*$/, 20, 4
            return cb 'invalid'
        request.get url, (e, r, data)->
          return cb data == '1'

social =
  targets: ['开心网','人人网','chinaren','新浪微博','腾讯微博','百度空间','5460同学录']
  category: 'social'
  rules:[
    '手机、邮箱'
    '手机、邮箱'
    '邮箱'
    '手机、邮箱'
    '用户ID(6~20位，由字母、数字、下划线或减号构成)'
    '邮箱'
    '邮箱'
  ]
  urls:[
    "http://www.kaixin001.com/"
    "http://www.renren.com/"
    "http://class.chinaren.com/index.jsp"
    "http://weibo.com/"
    "http://t.qq.com/login.php"
    "http://hi.baidu.com/"
    "http://sns.5460.net/"
  ]
  name: '社交网络'
  check: (i, name, cb)->
    switch i
      when 0
        if isEmail name
          url = "http://reg.kaixin001.com/interface/checkemail.php?email=#{name}"
        else if isTel name
          url = "http://reg.kaixin001.com/interface/checknickname.php?rg=mobile&nickname=#{name}"
        else
          return cb 'invalid'
        request.get url, (e, r, data)->
          return cb data == '0'
      when 1
        if isEmail name
          url = "http://reg.renren.com/AjaxRegisterAuth.do?authType=email&value=#{name}"
        else if isTel name
          url = "http://reg.renren.com/AjaxRegisterAuth.do?authType=email&stage=3&value=#{name}"
        else
          return cb 'invalid'
        request.post url, (e, r, data)->
          return cb data == 'OK'
      when 2
        return cb 'invalid' if !isEmail name
        url = "http://class.chinaren.com/a/passport/checkuser.do?passport=#{name}"
        request.get url, (e, r, data)->
          objdata = parseJson(data)
          if objdata and objdata.data and objdata.data.status
            return cb objdata.data.status == '0'
          return cb 'invalid'
      when 3
        if isTel name
          url = "http://weibo.com/signup/v5/formcheck?type=mobilesea&zone=0086&value=#{name}"
        else if isEmail name
          url = "http://weibo.com/signup/v5/formcheck?type=email&value=#{name}"
        else
          return cb 'invalid'

        request.get
          url: url
          headers:
            Referer: "http://weibo.com/signup/signup.php?ps=u3&lang=zh"
        , (e, r, data)->
          objdata = parseJson(data)
          if objdata and objdata.type
            return cb objdata.data.type == 'ok'
          return cb 'invalid'
      when 4
        if !formatValidation name, /^[a-zA-Z][a-zA-Z0-9_\-]*$/, 20, 6
          return cb 'invalid'
        request
          url: "http://api.t.qq.com/old/checkAccount.php?type=emailreg&account=#{name}"
          headers:
            Referer: "http://zc.qq.com/iframe/12/reg.html"
        ,(e, r, data)->
          return cb data.indexOf('Available') != -1
      when 5
        return cb 'invalid' if !isEmail name
        request.get "https://passport.baidu.com/v2/?regmailcheck&token=b959992e7171c26510acf1db7572696b&tpl=qing&apiver=v3&tt=1376224080016&email=#{name}&callback=bd__cbs__woibgk", (e,r,data)->
          return cb data.indexOf('"no": "0"') != -1
      when 6
        return cb 'invalid' if !isEmail name
        request.get "http://sns.5460.net/pages/Register/auth/zhuce!zhuce.action?email=#{name}", (e, r, data)->
          return cb data == '邮箱可用'

forum =
  targets: ['落伍者', '天涯', '搜狐社区', '网易论坛', '西祠胡同', '百度贴吧', '猫扑', '猫扑大杂烩', '新华网论坛', '凤凰网论坛', '阿里巴巴论坛', '瑞丽论坛', '青年论坛', '环球网论坛', '39健康网']
  category: 'forum'
  rules: [
    '邮箱、用户名(3~15个字符)'
    '邮箱、用户名(不超过8个中文)'
    '手机、邮箱'
    '邮箱'
    '邮箱、用户名(最长32个字符，仅限中英文数字下划线)'
    '手机、邮箱'
    '邮箱、用户名(4~20个字符)'
    '邮箱、用户名(4~20个字符)'
    '用户名(3~15个字符，仅限小写字母或数字)、昵称(2～15个字符)'
    '邮箱、用户名(3~20个中文、英文、数字、-、_组成，不允许以数字为开头)'
    '用户名(5~25个字符，由汉字、字母、数字、下划线构成)'
    '邮箱、昵称(3~15个字符)'
    '邮箱'
    '邮箱、用户名(4~24个字符)'
    '邮箱、手机'
  ]
  urls: [
    "http://www.im286.com/member.php?mod=logging&action=login"
    "http://www.tianya.cn/"
    "http://club.sohu.com/"
    "http://reg.163.com/"
    "http://www.xici.net/"
    "http://tieba.baidu.com/"
    "http://passport.mop.com"
    "http://passport.mop.com"
    "http://login.home.news.cn/index.jsp"
    "http://my.ifeng.com/?_c=index&_a=user-login"
    "https://login.1688.com/member/signin.htm"
    "http://user.rayli.com.cn/member.php?mod=logging&action=login"
    "http://t.youth.cn/"
    "http://passport.huanqiu.com/user.php?a=login"
    "http://www.39.net/"
  ]
  name: '论坛'
  check: (i, name, cb)->
    switch i
      when 0
        url = "http://www.im286.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{name}"
        if isEmail name
          url = "http://www.im286.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
        else
          if !formatValidation name, /^\S*$/, 15, 3
            return cb 'invalid'

        request.get url, (e, r, data)->
          return cb data.indexOf('succeed') != -1
      when 1
        url = "http://passport.tianya.cn/services/RegisterService?t=name&userName=#{name}"
        if isEmail name
          url = "http://passport.tianya.cn/services/RegisterService?t=email&email=#{name}"
        else
          if !formatValidation name, /^\S*$/, 16, 1
            return cb 'invalid'
        request.post
          url: url
          headers:
            Referer: "http://passport.tianya.cn/register/default.jsp?sourceURL=http%3A%2F%2Fwww.tianya.cn&from=index&_goto"
        , (e,r,data)->
          return cb data == '-1'
      when 2
        if isEmail name
          url = "http://rc.club.sohu.com/?action=ajax&cb=jQuery16309886482018046081_1376226011728&q%5Bevents%5D%5Bevname%5D=%5Bclub.userlive%5D&q%5Bevents%5D%5Bparams%5D%5Bnick%5D=%E6%B8%B8%E5%AE%A210dg01a&q%5BRegister%5D%5Buserid%5D=#{name}&q%5BRegister%5D%5Btype%5D=check_passport&_=1376226613160"
        else if isTel name
          url = "http://rc.club.sohu.com/?action=ajax&cb=jQuery16309886482018046081_1376226011730&q%5Bevents%5D%5Bevname%5D=%5Bclub.userlive%5D&q%5Bevents%5D%5Bparams%5D%5Bnick%5D=%E6%B8%B8%E5%AE%A210dg01a&q%5BRegister%5D%5Bmobile%5D=#{name}&q%5BRegister%5D%5Btype%5D=check_mobile&_=1376226681502"
        else
          return cb 'invalid'
        request.get
          url: url
          headers:
            Referer: "http://rc.club.sohu.com/?action=register&backurl=http%3A%2F%2Fclub.sohu.com"
            "X-Requested-With": "XMLHttpRequest"
        , (e,r,data)->
          return cb data.indexOf('\\"status\\":\\"0\\"') != -1 if isEmail name
          return cb data.indexOf('\\"status\\":\\"3\\"') != -1 if isTel name
      when 3
        return cb 'invalid' if !isEmail name
        url =
        request.get url, (e, r, data)->
          return cb data.indexOf("User does not exist") != -1
      when 4
        url = "http://www.xici.net/user/reg.asp?act=u&clientid=username&username=#{name}&&_=1376227335870"
        if isEmail name
          url = "http://www.xici.net/user/reg.asp?act=m&clientid=email&email=#{name}&&_=1376227319033"
        else
          if !formatValidation name, /^[\u4E00-\u9FFFa-zA-Z0-9_]*$/, 32, 1
            return cb 'invalid'
        request.get url, (e, r, data)->
          return cb data == '0'
      when 5
        if isTel name
          url = "https://passport.baidu.com/v2/?regphonecheck&token=ea4ac1f1501fe6f7e0fa776be9c1edf6&tpl=tb&apiver=v3&tt=1376228550606&phone=#{name}&callback=bd__cbs__8qrgto"
        else if isEmail name
          url = "https://passport.baidu.com/v2/?regmailcheck&token=ea4ac1f1501fe6f7e0fa776be9c1edf6&tpl=tb&apiver=v3&tt=1376228687883&email=#{name}&callback=bd__cbs__wv2xdo"
        else
          return cb 'invalid'
        request.get url, (e, r, data)->
          return cb data.indexOf('"no": "0"') != -1
      when 6, 7
        url = "http://passport.mop.com/register/uniqueAuth?userName=#{name}"
        if isEmail name
          url = "http://passport.mop.com/register/uniqueAuth?email=#{name}"
          request.get url, (e, r ,data)->
            return cb data.indexOf('true') != -1
          return
        else
          if !formatValidation name, /^[\u4E00-\u9FFFa-zA-Z0-9][\u4E00-\u9FFFa-zA-Z0-9_]*$/, 32, 1
            return cb 'invalid'
        request.get url, (e, r ,data)->
          return  cb data.indexOf('true') != -1
      when 8
        url = "http://my.home.news.cn/profile/passportCheck.do?name=userName&value=#{name}"
        if !formatValidation name, /^[a-z0-9]*$/, 15, 3
          if !formatValidation name, /.*/, 15, 2
            return cb 'invalid'
          else
              url = "http://my.home.news.cn/profile/passportCheck.do?name=nickName&value=#{name}"
        request.post url, (e, r ,data)->
          return cb data.indexOf('1100') != -1
      when 9
        if isEmail name
          request.get
            url: "http://my.ifeng.com/?_c=register&_a=check-email&e=#{name}"
            headers:
              Referer: "http://my.ifeng.com/?_c=register&_a=new-account"
          , (e, r, data)->
            return cb data == '1'
        else
          return cb 'invalid' if !formatValidation name, /^[\u4E00-\u9FFFa-zA-Z_\-][\u4E00-\u9FFFa-zA-Z0-9_\-]*$/, 40, 3
          request.post
            url: "http://my.ifeng.com/?_c=register&_a=check-username"
            form:
              u: name
            headers:
              Referer: "http://my.ifeng.com/?_c=register&_a=new-account"
          , (e, r, data)->
            return cb data == '1'
      when 10
        return cb 'invalid' if !formatValidation name, /^[\u4E00-\u9FFFa-zA-Z0-9_]*$/, 25, 5
        request.get "http://member.1688.com//member/ajax/check_login_id_and_recommend_json.do?callback=jQuery172015269904187880456_1376230277769&TPL_NICK=#{name}", (e, r, data)->
          return cb data.indexOf('true') != -1
      when 11
        if isEmail name
          url = "http://user.rayli.com.cn/forum.php?mod=ajax&infloat=register&handlekey=register&action=checkemail&ajaxmenu=1&email=#{name}&inajax=1&ajaxtarget=email_tip"
        else
          return cb 'invalid' if !formatValidation name, /^\S*$/, 15, 3
          url = "http://user.rayli.com.cn/forum.php?mod=ajax&infloat=register&handlekey=register_un&action=checkusername&ajaxmenu=1&username=#{name}&inajax=1&ajaxtarget=username_tip"
        request.get url, (e, r, data)->
          return cb data.indexOf('red') == -1
      when 12
        if isEmail name
          request.post
            url: "http://t.youth.cn/ajax.php?mod=member"
            form:
              code: 'check_email'
              check_value: name
          , (e, r, data)->
            return cb !data
        else
          return cb 'invalid'
      when 13
        if isEmail name
          url = "http://bbs.huanqiu.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
        else
          url = "http://bbs.huanqiu.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{name}"
          return cb 'invalid' if !formatValidation name, /^\S*$/, 24, 4
        request.get url, (e, r, data)->
          return cb data.indexOf('succeed') != -1
      when 14
        if isEmail name
          request.post
            url : "http://my.39.net/UserService.asmx/CheckEmailReg"
            form:
              pid: 0
              email: name
          , (e, r, data)->
            return cb data.indexOf('"Success":true') != -1
        else if isTel name
          request.post
            url : "http://my.39.net/UserService.asmx/CheckPhoneReg"
            form:
              pid: 0
              phone: name
          , (e, r, data)->
            return cb data.indexOf('"Success":true') != -1
        else
          return cb 'invalid' if !formatValidation name, /^[a-zA-Z][a-zA-Z0-9\-]*$/, 14, 4
          request.post
            url: "http://my.39.net/UserService.asmx/CheckUserNameJsOn"
            form:
              userName:name
          , (e, r, data)->
            return cb data.indexOf('"Success":true') != -1

appointment =
  targets: ['世纪佳缘', '百合网', '珍爱网', '嫁我网', '红娘网', '爱情公寓', '知己网', '绝对100婚恋网', '江南情缘']
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
  category: 'appointment'
  name: '约会'
  check: (i, name, cb)->
    switch i
      when 0
        if isEmail name
          url = 'http://reg.jiayuan.com/libs/xajax/reguser.server.php?processTraceUser'
          form =
            'xajax': 'processTraceUser'
            'xajaxargs[]': "<xjxquery><q>email=#{name}</q></xjxquery>"
            'xajaxargs[]': 'email'
        else if isTel name
          url = 'http://reg.jiayuan.com/libs/xajax/reguser.server.php?processUserMobile'
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
      when 1
        return cb 'invalid' if !isEmail(name) and !isTel name
        url = "http://love.baihe.com/EmailCheckForXs.action?email=#{name}"
        request.get url, (e, r, body)->
          return cb body.indexOf('"1"') != -1
      when 2
        return cb 'invalid' if !isTel name
        request.get "http://album.zhenai.com/register/validateMobile3.jsps?mobile=#{name}", (e, r, body)->
          return cb body == 'yes'
      when 3
        return cb 'invalid' if !isEmail name
        request.get "http://www.marry5.com/sso/CheckEmail?email=#{name}", (e, r, body)->
          return cb body == '0'
      when 4
        if isEmail name
          request.get "http://7651.com/site/ajaxcheckname?username=#{name}", (e, r ,body)->
            return cb body == '1'
        else if isTel name
          request.post
            url: "http://7651.com/site/cktel"
            form:
              telphone: name
          , (e, r, body)->
            return cb body == ''
        else
          return cb 'invalid'
      when 5
        if isEmail name
          form = param: "{'action':'validate_email','email':'#{name}'}"
        else
          return cb 'invalid' if !formatValidation name, /^[a-z0-9]*$/, 16, 3
          form = param: "{'action':'validate_id','userid':'#{name}'}"

        request.post
          url: 'http://www.ipart.cn/register_new/register_response_final.php'
          form: form
        ,(e, r, body)->
          return cb body == '0'
      when 6
        return cb 'invalid' if !formatValidation name, /^[a-zA-Z0-9]*[a-zA-Z]+[a-zA-Z0-9]*$/, 20, 1
        request.post
          url: "http://www.zhiji.com/ajax.asp?checksubmit=yes"
          form:
            action:'checkusername_lay'
            username: name
        ,(e, r, body)->
          return cb body.indexOf('//window.parent.document.getElementById("Regbtn").disabled=false;') != -1
      when 7
        return cb 'invalid' if !isEmail name

        request.get "http://www.juedui100.com/ajax/identifyEmail?email=#{name}", (e, r, body)->
          return cb body == '0'
      when 8
        return cb 'invalid' if !isEmail name
        request.get "http://www.88999.com/Register/checkExistAction.aspx?email=#{name}", (e, r, body)->
          return cb body == '0'

discuz =
  targets: ['社区动力', '社区门户', '站帮网', '若人论坛', '魔客吧']
  rules: [
    '邮箱、用户ID(3~15个字符)'
    '邮箱、用户ID(3~15个字符)'
    '邮箱、用户ID(3~15个字符)'
    '邮箱、用户ID(3~15个字符)'
    '邮箱、用户ID(3~15个字符)'
  ]
  urls:[
    "http://www.discuz.net/forum.php"
    "http://lasg.cn/"
    "http://bbs.zb7.com/"
    "http://bbs.ruoren.com/"
    "http://www.moke8.com/"
  ]
  category: 'discuz'
  name: 'Discuz论坛'
  check: (i, name, cb)->
    switch i
      when 0
        url = "http://www.discuz.net/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{encodeURIComponent name}"
        if isEmail name
          url = "http://www.discuz.net/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
        else
          return cb 'invalid' if !formatValidation name, '', 15, 3
        request.get url, (e, r, data)->
          return cb data.indexOf('succeed') != -1

      when 1
        url = "http://bbs.lasg.ac.cn/bbs/ajax.php?inajax=1&action=checkusername&username=#{encodeURIComponent name}"
        if isEmail name
          url = "http://bbs.lasg.ac.cn/bbs/ajax.php?inajax=1&action=checkemail&email=#{name}"
        else
          return cb 'invalid' if !formatValidation name, '', 15, 3
        request.get url, (e, r, data)->
          return cb data?.indexOf?('succeed') != -1

      when 2
        url = "http://www.zb7.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{encodeURIComponent name}"
        if isEmail name
          url = "http://www.zb7.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
        else
          return cb 'invalid' if !formatValidation name, '', 15, 3
        request.get url, (e, r, data)->
          return cb data.indexOf('succeed') != -1

      when 3
        url = "http://bbs.ruoren.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{encodeURIComponent name}"
        if isEmail name
          url = "http://bbs.ruoren.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
        else
          return cb 'invalid' if !formatValidation name, '', 15, 3

        request.get url, (e, r, data)->
          return cb data.indexOf('succeed') != -1
      when 4
        url = "http://www.moke8.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{encodeURIComponent name}"
        if isEmail name
          url = "http://www.moke8.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
        else
          return cb 'invalid' if !formatValidation name, '', 15, 3
        request.get url, (e, r, data)->
          return cb data.indexOf('succeed') != -1

categories = [email, extra, social, forum, appointment, discuz]

module.exports.allchks = (cb)->
  chks = {}
  for k, i in categories
    chk =
      name: k.name
    chk.cid = i
    chk.desc = k.desc if k.desc
    chk.targets = k.targets.slice 0
    chk.rules = k.rules.slice 0
    chk.urls = k.urls.slice 0
    chks[k.category] = chk
  console.log chks
  return cb chks

module.exports.check = (cid, name, cb)->
  return cb 'error' if !name
  categories[Math.floor cid/100].check cid%100, name, cb


# only this line add by super
module.exports.categories = categories
