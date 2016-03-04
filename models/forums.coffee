module.exports = forums =
  targets: ['落伍者', '天涯', '搜狐社区', '网易论坛', '西祠胡同', '百度贴吧', '猫扑', '猫扑大杂烩', '新华网论坛', '凤凰网论坛', '阿里巴巴论坛', '瑞丽论坛', '青年论坛', '环球网论坛', '39健康网']
  category: 'forum'
  name: '论坛'
  cid: 3
  agent:''
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
  validate_urls: {
    email: [
      "http://www.im286.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
      "http://passport.tianya.cn/services/RegisterService?t=email&email=#{name}"
      "http://rc.club.sohu.com/?action=ajax&cb=jQuery16309886482018046081_1376226011728&q%5Bevents%5D%5Bevname%5D=%5Bclub.userlive%5D&q%5Bevents%5D%5Bparams%5D%5Bnick%5D=%E6%B8%B8%E5%AE%A210dg01a&q%5BRegister%5D%5Buserid%5D=#{name}&q%5BRegister%5D%5Btype%5D=check_passport&_=1376226613160"
      "http://reg.163.com/services/checkUsername?username=#{name}&product=urs"
      "http://www.xici.net/user/reg.asp?act=m&clientid=email&email=#{name}&&_=1376227319033"
      "https://passport.baidu.com/v2/?regmailcheck&token=ea4ac1f1501fe6f7e0fa776be9c1edf6&tpl=tb&apiver=v3&tt=1376228687883&email=#{name}&callback=bd__cbs__wv2xdo"
      "http://passport.mop.com/register/uniqueAuth?email=#{name}"
      "http://passport.mop.com/register/uniqueAuth?email=#{name}"
    ]
    tel: [
      ""
      ""
      "http://rc.club.sohu.com/?action=ajax&cb=jQuery16309886482018046081_1376226011730&q%5Bevents%5D%5Bevname%5D=%5Bclub.userlive%5D&q%5Bevents%5D%5Bparams%5D%5Bnick%5D=%E6%B8%B8%E5%AE%A210dg01a&q%5BRegister%5D%5Bmobile%5D=#{name}&q%5BRegister%5D%5Btype%5D=check_mobile&_=1376226681502"
      ""
      ""
      "https://passport.baidu.com/v2/?regphonecheck&token=ea4ac1f1501fe6f7e0fa776be9c1edf6&tpl=tb&apiver=v3&tt=1376228550606&phone=#{name}&callback=bd__cbs__8qrgto"
      ""
      ""
    ]
    name:[
      "http://www.im286.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{name}"
      "http://passport.tianya.cn/services/RegisterService?t=name&userName=#{name}"
      ""
      ""
      "http://www.xici.net/user/reg.asp?act=u&clientid=username&username=#{name}&&_=1376227335870"
      ""
      "http://passport.mop.com/register/uniqueAuth?userName=#{name}"
      "http://passport.mop.com/register/uniqueAuth?userName=#{name}"
      "http://my.home.news.cn/profile/passportCheck.do?name=userName&value=#{name}"
    ]
  }
  referer:[
    ""
    "http://passport.tianya.cn/register/default.jsp?sourceURL=http%3A%2F%2Fwww.tianya.cn&from=index&_goto"
    "http://rc.club.sohu.com/?action=register&backurl=http%3A%2F%2Fclub.sohu.com"
  ]
  format: [
    {
      regex: /^\S*$/
      max: 15
      min: 3
    }
    {
      regex: /^\S*$/
      max: 16
      min: 1
    }
    undefined
    undefined
    {
      regex: /^[\u4E00-\u9FFFa-zA-Z0-9_]*$/
      max: 32
      min: 1
    }
  ]
  check:
    (name, cb)->
      url_base = validate_urls_base[0]
      url = "#{url_base}&action=checkusername&username=#{name}"
      if isEmail name
        url = "#{url_base}&action=checkemail&email=#{name}"
      else
        if !formatValidation name, /^\S*$/, 15, 3
          return cb 'invalid'
      request.get url, (e, r, data)->
        return cb data.indexOf('succeed') != -1
