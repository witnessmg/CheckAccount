module.exports = forums =

  category: 'forum'

  name: '论坛'

  cid: 3

  agent:''

  members:
    {
      info:
        _target: '落伍者'
        _rule: '邮箱、用户名(3~15个字符)'
        _href: "http://www.im286.com/member.php?mod=logging&action=login"

      req:
        _email:
          url: "http://www.im286.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
          method: 'GET'
          resultkeyword: '0'

        _name:
          url: "http://www.im286.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{name}"
          method: 'GET'
          resultkeyword: '0'
          format:
            regex: /^\S*$/
            max: 15
            min: 3
    }
    {
      info:
        _target: '天涯'
        _rule: '邮箱、用户名(不超过8个中文)'
        _href: "http://www.tianya.cn/"

      req:
        _email:
          url: "http://passport.tianya.cn/services/RegisterService?t=email&email=#{name}"
          param:
            headers:
              referer: "http://passport.tianya.cn/register/default.jsp?sourceURL=http%3A%2F%2Fwww.tianya.cn&from=index&_goto"
          method: 'POST'
          resultkeyword: '-1'

        _name:
          url: "http://passport.tianya.cn/services/RegisterService?t=name&userName=#{name}"
          param:
            headers:
              referer: "http://passport.tianya.cn/register/default.jsp?sourceURL=http%3A%2F%2Fwww.tianya.cn&from=index&_goto"
          method: 'POST'
          resultkeyword: '-1'
          format:
            regex: /^\S*$/
            max: 16
            min: 1
    }
    {
      info:
        _target: '搜狐社区'
        _rule: '手机、邮箱'
        _href: "http://club.sohu.com/"

      req:
        _email:
          url: "http://rc.club.sohu.com/?action=ajax&cb=jQuery16309886482018046081_1376226011728&q%5Bevents%5D%5Bevname%5D=%5Bclub.userlive%5D&q%5Bevents%5D%5Bparams%5D%5Bnick%5D=%E6%B8%B8%E5%AE%A210dg01a&q%5BRegister%5D%5Buserid%5D=#{name}&q%5BRegister%5D%5Btype%5D=check_passport&_=1376226613160"
          method: 'GET'
          param:
            headers:
              Referer: "http://rc.club.sohu.com/?action=register&backurl=http%3A%2F%2Fclub.sohu.com"
              "X-Requested-With": "XMLHttpRequest"
          resultkeyword: '\\"status\\":\\"0\\"'

        _tel:
          url: "http://rc.club.sohu.com/?action=ajax&cb=jQuery16309886482018046081_1376226011730&q%5Bevents%5D%5Bevname%5D=%5Bclub.userlive%5D&q%5Bevents%5D%5Bparams%5D%5Bnick%5D=%E6%B8%B8%E5%AE%A210dg01a&q%5BRegister%5D%5Bmobile%5D=#{name}&q%5BRegister%5D%5Btype%5D=check_mobile&_=1376226681502"
          method: 'GET'
          param:
            headers:
              Referer: "http://rc.club.sohu.com/?action=register&backurl=http%3A%2F%2Fclub.sohu.com"
              "X-Requested-With": "XMLHttpRequest"
          resultkeyword: '\\"status\\":\\"3\\"'
    }
    {
      info:
        _target: '网易论坛'
        _rule: '邮箱'
        _href: "http://reg.163.com/"

      req:
        _email:
          url: "http://reg.163.com/services/checkUsername?username=#{name}&product=urs"
          method: 'GET'
          resultkeyword: "User does not exist"
    }
    {
      info:
        _target: '西祠胡同'
        _rule: '邮箱、用户名(最长32个字符，仅限中英文数字下划线)'
        _href: "http://www.xici.net/"

      req:
        _email:
          url: "http://www.xici.net/user/reg.asp?act=m&clientid=email&email=#{name}&&_=1376227319033"
          method: 'GET'
          resultkeyword: '0'

        _name:
          url: "http://www.xici.net/user/reg.asp?act=u&clientid=username&username=#{name}&&_=1376227335870"
          method: 'GET'
          resultkeyword: '0'
          format:
            max: 32
            min: 1
            regex: /^[\u4E00-\u9FFFa-zA-Z0-9_]*$/
    }
    {
      info:
        _target: '百度贴吧'
        _rule: '手机、邮箱'
        _href: "http://tieba.baidu.com/"

      req:
        _email:
          url:"https://passport.baidu.com/v2/?regmailcheck&token=ea4ac1f1501fe6f7e0fa776be9c1edf6&tpl=tb&apiver=v3&tt=1376228687883&email=#{name}&callback=bd__cbs__wv2xdo"
          method: 'GET'
          resultkeyword: '"no": "0"'

        _tel:
          url: "https://passport.baidu.com/v2/?regphonecheck&token=ea4ac1f1501fe6f7e0fa776be9c1edf6&tpl=tb&apiver=v3&tt=1376228550606&phone=#{name}&callback=bd__cbs__8qrgto"
          method: 'GET'
          resultkeyword: '"no": "0"'
    }
    {
      info:
        _target: '猫扑'
        _rule: '邮箱、用户名(4~20个字符)'
        _href: "http://passport.mop.com"

      req:
        _email:
          url: "http://passport.mop.com/register/uniqueAuth?email=#{name}"
          method: 'GET'
          resultkeyword: 'true'

        _name:
          url: "http://passport.mop.com/register/uniqueAuth?userName=#{name}"
          method: 'GET'
          resultkeyword: 'true'
          format:
            regex: /^[\u4E00-\u9FFFa-zA-Z0-9][\u4E00-\u9FFFa-zA-Z0-9_]*$/
            max: 32
            min: 1
    }
    {
      info:
        _target: '猫扑'
        _rule: '邮箱、用户名(4~20个字符)'
        _href: "http://passport.mop.com"

      req:
        _email:
          url: "http://passport.mop.com/register/uniqueAuth?email=#{name}"
          method: 'GET'
          resultkeyword: 'true'

        _name:
          url: "http://passport.mop.com/register/uniqueAuth?userName=#{name}"
          method: 'GET'
          resultkeyword: 'true'
          format:
            regex: /^[\u4E00-\u9FFFa-zA-Z0-9][\u4E00-\u9FFFa-zA-Z0-9_]*$/
            max: 32
            min: 1
    }
    {
      info:
        _target: '新华网论坛'
        _rule: '用户名(3~15个字符，仅限小写字母或数字)、昵称(2～15个字符)'
        _href: "http://login.home.news.cn/index.jsp"

      req:
        _name:
          url:
            "http://my.home.news.cn/profile/passportCheck.do?name=userName&value=#{name}"
            "http://my.home.news.cn/profile/passportCheck.do?name=nickName&value=#{name}"
          format:
            {
              regex: /^[a-z0-9]*$/
              max: 15
              min: 3
            }
            {
              regex: /.*/
              max: 15
              min: 2
            }
    }
    {
      info:
        _target: '凤凰网论坛'
        _rule: '邮箱、用户名(3~20个中文、英文、数字、-、_组成，不允许以数字为开头)'
        _href: "http://my.ifeng.com/?_c=index&_a=user-login"

      req:
        _email:
          url: "http://my.ifeng.com/?_c=register&_a=check-email&e=#{name}"
          param:
            headers:
              referer: "http://my.ifeng.com/?_c=register&_a=new-account"
          method: 'GET'
          resultkeyword: '1'

        _name:
          url: "http://user.rayli.com.cn/forum.php?mod=ajax&infloat=register&handlekey=register_un&action=checkusername&ajaxmenu=1&username=#{name}&inajax=1&ajaxtarget=username_tip"
          method: 'POST'
          param:
            form:
              u: name
            headers:
              referer: "http://my.ifeng.com/?_c=register&_a=new-account"
          resultkeyword: '1'
          format:
            regex:  /^\S*$/
            max: 15
            min: 3
    }
    {
      info:
        _target: '阿里巴巴论坛'
        _rule: '用户名(5~25个字符，由汉字、字母、数字、下划线构成)'
        _href: "https://login.1688.com/member/signin.htm"

      req:
        _name:
          url: "http://member.1688.com//member/ajax/check_login_id_and_recommend_json.do?callback=jQuery172015269904187880456_1376230277769&TPL_NICK=#{name}"
          method: 'GET'
          resultkeyword: 'true'
          format:
            regex: /^[\u4E00-\u9FFFa-zA-Z0-9_]*$/
            max: 25
            min: 5
    }
    {
      info:
        _target: '瑞丽论坛'
        _rule: '邮箱、昵称(3~15个字符)'
        _href: "http://user.rayli.com.cn/member.php?mod=logging&action=login"

      req:
        _email:
          url: "http://user.rayli.com.cn/forum.php?mod=ajax&infloat=register&handlekey=register&action=checkemail&ajaxmenu=1&email=#{name}&inajax=1&ajaxtarget=email_tip"
          method: 'GET'
          resultkeyword: 'red'

        _name:
          url: "http://user.rayli.com.cn/forum.php?mod=ajax&infloat=register&handlekey=register_un&action=checkusername&ajaxmenu=1&username=#{name}&inajax=1&ajaxtarget=username_tip"
          method: 'GET'
          resultkeyword: 'red'
          format:
            regex: /^\S*$/
            max: 15
            min: 3
    }
    {
      info:
        _target: '青年论坛'
        _rule: '邮箱'
        _href: "http://t.youth.cn/"

      req:
        _email:  "http://t.youth.cn/ajax.php?mod=member"
          method: 'POST'
          param:
            form:
              code: 'check_email'
              check_value: name
    }
    {
      info:
        _target: '环球网论坛'
        _rule: '邮箱、用户名(4~24个字符)'
        _href: "http://passport.huanqiu.com/user.php?a=login"

      req:
        _email:
          url:  "http://bbs.huanqiu.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
          method: 'GET'
          resultkeyword: 'succeed'
        _name:
          url: "http://bbs.huanqiu.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{name}"
          method: 'GET'
          resultkeyword: 'succeed'
          format:
            max: 24
            min: 4
            regex: /^\S*$/
    }
    {
      info:
        _target: '39健康网'
        _rule: '邮箱、手机'
        _href: "http://www.39.net/"

      req:
        _email:
          url: "http://my.39.net/UserService.asmx/CheckEmailReg"
          method: 'POST'
          param:
            form:
              pid: 0
              email: name
          resultkeyword: '"Success":true'

        _tel:
          url: "http://my.39.net/UserService.asmx/CheckPhoneReg"
          method: 'POST'
          param:
            form:
              pid: 0
              email: name
          resultkeyword: '"Success":true'

        _name:
          url: "http://my.39.net/UserService.asmx/CheckUserNameJsOn"
          method: 'POST'
          param:
            form:
              email: name
          resultkeyword: '"Success":true'
          format:
            max: 14
            min: 4
            regex: /^[a-zA-Z][a-zA-Z0-9\-]*$/
    }
