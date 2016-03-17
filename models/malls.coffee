module.exports = malls =

  category: 'mall'

  name: '商城'

  cid: 6

  members:
    {
      info:
        _target: '京东'
        _rule: '邮箱、手机号、用户名(4-20位字符)'
        _href: 'http://www.jd.com/'

      req:
        _email:
          options:
            url: "https://reg.jd.com/validateuser/isEmailEngaged?email=#{name}"
          method: 'GET'
          resultkeyword: ['success', '0']

        _tel:
          options:
            url: "https://reg.jd.com/validateuser/isMobileEngaged?mobile=#{name}"
          method: 'GET'
          resultkeyword: ['success','0']

        _name:
          options:
            url: "https://reg.jd.com/validateuser/isPinEngaged?pin=#{name}"
          method: 'GET'
          resultkeyword: ['success', '0']
          format:
            regex: /[a-zA-Z0-9\-\_]{4,20}/
            max: 20
            min: 4
    }
    {
      info:
        _target: '易迅'
        _rule: '手机号、易迅账号、第三方登录'
        _href: 'www.yixun.com'

      req:
        _tel:
          options:
            url: 'https://ecclogin.yixun.com/login/sendidentifycode?callback=jQuery110209682811319362372_1458178814171&mobile=18918925172'
            rejectUnauthorized: false
            headers:
              'Referer': 'https://ecclogin.yixun.com/login/loginui?appid=700024506&e_appid=1&e_surl=https://base.yixun.com/iframejump.html&e_other_login=1&e_height=420&e_wx_login=1'
              'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36'
        # _name:
        #   options:
        #     url: ''
   }
