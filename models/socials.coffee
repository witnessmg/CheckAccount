module.exports = socials =

  category: 'social'

  cid: 2

  name: '社交网络'

  members:
    {
      info:
        _target: '开心网'
        _rule: '手机、邮箱'
        _href: "http://www.kaixin001.com/"

      req:
        _email:
          url: "http://reg.kaixin001.com/interface/checkemail.php?email=#{name}"
          method: 'GET'
          resultkeyword: '0'

        _tel:
          url: "http://reg.kaixin001.com/interface/checknickname.php?rg=mobile&nickname=#{name}"
          method: 'GET'
          resultkeyword: '0'
    }
    {
      info:
        _target: '人人网'
        _rule: '手机、邮箱'
        _href: "http://www.renren.com/"

      req:
        _email:
          url: "http://reg.renren.com/AjaxRegisterAuth.do?authType=email&value=#{name}"
          method: 'POST'
          resultkeyword: 'OK'

        _tel:
          url: "http://reg.renren.com/AjaxRegisterAuth.do?authType=email&stage=3&value=#{name}"
          method: 'POST'
          resultkeyword: 'OK'
    }
    {
      info:
        _target: 'chinaren'
        _rule: '邮箱'
        _href: "http://class.chinaren.com/index.jsp"

      req:
        _email:
          url: "http://class.chinaren.com/a/passport/checkuser.do?passport=#{name}"
          method: 'GET'
          resultkeyword: '0'
    }
    {
      info:
        _target: '新浪微博'
        _rule: '手机、邮箱'
        _href: "http://weibo.com/"

      req:
        _email:
          url: "http://weibo.com/signup/v5/formcheck?type=email&value=#{name}"
          method: 'GET'
          param:
            headers:
              Referer: "http://weibo.com/signup/signup.php?ps=u3&lang=zh"
          resultkeyword:'OK'

        _tel:
          url: "http://weibo.com/signup/v5/formcheck?type=mobilesea&zone=0086&value=#{name}"
          method: 'GET'
          param:
            headers:
              Referer: "http://weibo.com/signup/signup.php?ps=u3&lang=zh"
          resultkeyword:'OK'
    }
    {
      info:
        _target: '腾讯微博'
        _rule: '用户ID(6~20位，由字母、数字、下划线或减号构成)'
        _href: "http://t.qq.com/login.php"

      req:
        _name:
          url: "http://api.t.qq.com/old/checkAccount.php?type=emailreg&account=#{name}"
          method: 'GET'
          param:
            headers:
              Referer: "http://zc.qq.com/iframe/12/reg.html"
          format:
            regex: /^[a-zA-Z][a-zA-Z0-9_\-]*$/
            max: 20
            min: 6
          resultkeyword: 'Available'
    }
    {
      info:
        _target: '百度空间'
        _rule: '邮箱'
        _href: "http://hi.baidu.com/"

      req:
        _email:
          url: "https://passport.baidu.com/v2/?regmailcheck&token=b959992e7171c26510acf1db7572696b&tpl=qing&apiver=v3&tt=1376224080016&email=#{name}&callback=bd__cbs__woibgk"
          method: 'GET'
          resultkeyword: '"no": "0"'
    }
    {
      info:
        _target: '5460同学录'
        _rule: '邮箱'
        _href: "http://sns.5460.net/"

      req:
        _email:
          url: "http://sns.5460.net/pages/Register/auth/zhuce!zhuce.action?email=#{name}"
          method: 'GET'
          resultkeyword: '邮箱可用'
    }
