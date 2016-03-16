module.exports = malls =

  category: 'mall'

  name: '商城'

  cid: 6

  options:
    {
      info:
        _target: '京东'
        _rule: '邮箱、手机号、用户名(4-20位字符)'
        _href: 'http://www.jd.com/'

      req:
        _email:
          url: "https://reg.jd.com/validateuser/isEmailEngaged?email=#{name}"
          method: 'GET'
          resultkeyword: ['success', '0']

        _tel:
          url: "https://reg.jd.com/validateuser/isMobileEngaged?mobile=#{name}"
          method: 'GET'
          resultkeyword: ['success','0']

        _name:
          url: "https://reg.jd.com/validateuser/isPinEngaged?pin=#{name}"
          method: 'GET'
          resultkeyword: ['success', '0']
          format:
            regex: /[a-zA-Z0-9\-\_]{4,20}/
            max: 20
            min: 4
    }
