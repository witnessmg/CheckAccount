module.exports = emails =

  cid: 0

  category: 'email'

  name: '邮箱'

  desc: '若待检测的为邮箱帐号，则该项只检测"@"之前的用户名'

  members: [
      {
        info:
          _target: '163邮箱'
          _rule: '手机号或6~18个字符，可使用字母、数字、下划线，需以字母开头'
          _href: "http://mail.163.com/"

        req:
          _email:
            suffix: '@163.com'
            method: 'SMTP'
      }
      {
        info:
          _target: '126邮箱'
          _rule: '手机号或6~18个字符，可使用字母、数字、下划线，需以字母开头'
          _href: "http://mail.126.com/"

        req:
          _email:
            suffix: '@126.com'
            method:'SMTP'
      }
      {
        info:
          _target: '网易yeah邮箱'
          _rule: '手机号或6~18个字符，可使用字母、数字、下划线，需以字母开头'
          _href: "http://www.yeah.net/"

        req:
          _email:
            suffix: '@yeah.net'
            method: 'SMTP'
      }
      {
        info:
          _target: 'Google邮箱'
          _rule: '6~30个字符，可实用字母、数字、点'
          _href: "https://mail.google.com/"

        req:
          _email:
            suffix: '@gmail.com'
            method: 'SMTP'
      }
      {
        info:
          _target: '搜狐邮箱'
          _rule: '6-18个字符，仅支持字母、数字及“.”、”-”、”_”，不能全部数字或下划线'
          _href: "http://mail.sohu.com/"

        req:
          _name:
            url: "http://passport.sohu.com/signup/check_email"
            method: 'POST'
            form:
              email: '#{name}@sohu.com'
            format:
              max: 16
              min: 4
              regex: /^[a-zA-Z][a-zA-Z0-9_\-\.]*$/
            resultkeyword: [code, 0]
      }
      {
        info:
          _target: 'tom邮箱'
          _rule: '4-16位，数字、小写字母、点、减号或下划线，小写字母开头'
          _href:  "http://web.mail.tom.com/webmail/login/index.action"

        req:
          _name:
            url: "http://web.mail.tom.com/webmail/register/checkname.action?userName=#{name}"
            method: 'GET'
            resultkeyword: ['isUserNameExist', true]
            format:
              max: 18
              min: 6
              regex: /^[a-zA-Z0-9_\-\.]*$/

      }
      {
        info:
          _target: '搜狗邮箱'
          _rule: '手机号或4~16个字符、包括字母、数字、下划线、中划线，字母开头，非特殊字符结尾，不区分大小写'
          _href:  "http://mail.sogou.com/"

        req:
          _name:
            url: "https://account.sogou.com/web/account/checkusername?username=#{name}"
            method: 'GET'
            resultkeyword: ['status', 0]
      }
      {
        info:
          _target: '21CN邮箱'
          _rule: '5至20个英文字母、数字、点、减号或下划线组成'
          _href:  "http://mail.21cn.com/"

        req:
          _suffix: '@21cn.com'
          _method: 'STMP'
      }
      {
        info:
          _target: '188财富邮箱'
          _rule: '4-16位，数字、小写字母、下划线，下划线不能在首尾'
          _href:  "http://188.com/"

        req:
          _suffix: '@188.com'
          _method: 'STMP'
      }
      {
        info:
          _target: '新浪邮箱(.com)'
          _rule: ''
          _href:  "http://mail.sina.com.cn/"

        req:
          _name: "https://mail.sina.com.cn/register/chkmail.php"
            suffix: '@sina.com'
            method: 'POST'
            resultkeyword: ['result', true]
            format:
              max: 16
              min: 6
              regex: /^[a-z0-9][a-z0-9_]*[a-z0-9]$/

      }
      {
        info:
          _target: '新浪邮箱(.cn)'
          _rule: '4-16位，数字、小写字母、点、减号或下划线，小写字母开头'
          _href: "http://mail.sina.com.cn/"

        req:
          _name: "https://mail.sina.com.cn/register/chkmail.php"
            suffix: '@sina.cn'
            method: 'POST'
            resultkeyword: ['result', true]
            format:
              max: 16
              min: 6
              regex: /^[a-z0-9][a-z0-9_]*[a-z0-9]$/
      }
    ]
