module.exports = extras =

  category: 'extra'

  cid: 1

  name: '其他'

  members:
    {
      info:

        _target: '芒果网'
        _rule: '手机、邮箱、用户ID(6~12位，字母或数字)'
        _href: "http://www.mangocity.com/mbrweb/login/init.action"

      req:
        _email:

          url: "http://www.mangocity.com/mbrweb/validate/validateVerifyCode.action?verifyCode=0297&countryMobileNo=86&emailNo=#{name}"
          method: 'POST'
          resultkeyword: 'N'

        _tel:

          url: "http://www.mangocity.com/mbrweb/validate/validateVerifyCode.action?verifyCode=0297&mobileNo=#{name}"
          method: 'POST'
          resultkeyword: 'N'

        _name:

          url: "http://www.mangocity.com/mbrWebCenter/validate_new/validateUsername.action"
          method: 'POST'
          resultkeyword: 'N'
          format:
            max: 12
            min: 6
            regex: /^[a-zA-Z0-9]*$/

    }
    {
      info:
        _target: '优酷'
        _rule: '手机、邮箱、昵称(2个中文或4个字符)'
        _href: "http://www.youku.com/user_login/"

      req:
        _email:
          url: "http://www.youku.com/user/chk_mail?__rt=1&__ro=&key=email&vo=#{name}"
          method: 'GET'
          resultkeyword: '1'

        _tel:
          url: "http://www.youku.com/user/chkAccount?__rt=1&__ro=&inputs=#{name}"
          method: 'GET'
          resultkeyword: '1'

        _name:
          url: "http://www.youku.com/user/chk/?__rt=1&__ro=&key=username&vo=#{name}"
          method: 'GET'
          resultkeyword: '1'
          format:
            max: 38
            min: 4
            name: /^[\u4E00-\u9FFFa-zA-Z0-9_\-]*$/
    }
    {
      info:
        _target: '精品网'
        _rule: '邮箱、用户ID(字母开头，5~12位，由英文，数字，"－"，"_"构成)'
        _href: "http://my.sg.com.cn/"

      req:
        _email:
          url: "http://reg.sg.com.cn/action.php?ac=check_unique&type=users_email&value=#{name}"
          method: 'GET'
          resultkeyword: '1'

        _name:
          url: "http://reg.sg.com.cn/action.php?ac=check_unique&type=users_name&value=#{name}"
          method: 'GET'
          resultkeyword: '1'
          format:
            max: 12
            min: 5
            regex: /^[a-zA-Z][a-zA-Z0-9\-_]*$/
    }
    {
      info:
        _target: '58团购'
        _rule: '邮箱、用户名(4~20位，由汉字、数字、字母和"_"组成)'
        _href: "http://passport.58.com/login"

      req:
        _email:
          url: "http://passport.58.com/ajax/checkemail?id=421&email=#{name}"
          method: 'GET'
          resultkeyword: '1'

        _name:
          url: "http://passport.58.com/ajax/checknickname?id=8669&nickname=#{name}"
          method: 'GET'
          resultkeyword: '1'
          format:
            max: 20
            min: 4
            regex: /^[\u4E00-\u9FFFa-zA-Z0-9_]*$/
    }
