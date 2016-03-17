module.exports = appointments =

  name: '约会'

  category: 'appointment'

  cid: 4

  members:[
    {
      info:

        _target: '世纪佳缘'
        _rule: '手机、邮箱'
        _href: "http://login.jiayuan.com/"

      req:
        _email:

           method: 'POST'
           options:
             url: "http://reg.jiayuan.com/libs/xajax/reguser.server.php?processTraceUser"
             form:
               'xajax': 'processTraceUser'
               'xajaxargs[]': "<xjxquery><q>email=#{name}</q></xjxquery>"
               'xajaxargs[]': 'email'
           keyword: 'exactness'

        _tel:

          method: 'POST'
          options:
            url: "http://reg.jiayuan.com/libs/xajax/reguser.server.php?processUserMobile"
            form:
            'xajax': 'processUserMobile'
            'xajaxargs[]': "<xjxquery><q>mobile=#{name}</q></xjxquery>"
          keyword: 'exactness'

    }
    {
      info:

        _target: '百合网'
        _rule: '手机、邮箱'
        _href: "http://passport.baihe.com/login.jsp"

      req:
        _email:

          method: 'GET'
          options:
            url: "http://my.baihe.com/register/emailCheckForXs?email=#{name}"
          keyword: ['state', 1]

        _tel:

          method: 'GET'
          options:
            url: "http://my.baihe.com/register/emailCheckForXs?email=#{name}"
          keyword: ['state', 1]
    }
    {
      info:

        _target: '珍爱网'
        _rule: '手机'
        _href: "http://album.zhenai.com/login/login.jsp"

      req:
        _tel:

          method: 'GET'
          options:
            url: "http://album.zhenai.com/register/validateMobile3.jsps?mobile=#{name}"
          keyword: 'yes'
    }
    {
      info:

        _target: '红娘网'
        _rule: '手机、邮箱'
        _href: "http://7651.com/login/enter.html"

      req:
        _email:

          method: 'GET'
          options:
            url: "http://7651.com/site/ajaxcheckname?username=#{name}"
          keyword: '1'

        _tel:

          method: 'POST'
          options:
            url: "http://7651.com/site/cktel"
            form:
              telphone: name
          keyword: ''

    }
    {
      info:

        _target: '知己网'
        _rule: '用户名(20位以内中英文数字，不能为纯数字)'
        _href: "http://www.zhiji.com/"

      req:
        _name:

          method: 'POST'
          options:
            url: "http://www.zhiji.com/ajax.asp?checksubmit=yes"
            form:
              action:'checkusername_lay'
              username: name
          keyword: '//window.parent.document.getElementById("Regbtn").disabled=false;'
          format:
            regex: /^[a-zA-Z0-9]*[a-zA-Z]+[a-zA-Z0-9]*$/
            max: 20
            min: 1

    }
    {
      info:

        _target: '爱真心'
        _rule: '邮箱'
        _href: "http://www.izhenxin.com/"

      req:
        _email:

          method: 'POST'
          options:
            url: "http://www.izhenxin.com/register/checkEmail/?email=#{name}"
          keyword: '1'

        _tel:

          method: 'POST'
          options:
            url: "http://www.izhenxin.com/register/checkMobile/?mobile=#{name}"
          keyword: '1'

    }
    {
      info:

        _target: '江南情缘'
        _rule: '邮箱'
        _href:  "www.jnqy.com"

      req:
        _email:

          method: 'GET'
          options:
            url: "http://www.jnqy.com/Register/checkExistAction.aspx?email=#{name}"
          keyword: '0'

    }
  ]
