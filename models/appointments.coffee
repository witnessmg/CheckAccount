module.exports = appointments =

  name: '约会'

  category: 'appointment'

  cid: 4

  options:[
    {
      info:
        _target: '世纪佳缘'
        _rule: '手机、邮箱'
        _href: "http://login.jiayuan.com/"
      req:
        _email:
           url: "http://reg.jiayuan.com/libs/xajax/reguser.server.php?processTraceUser"
           method: 'POST'
           param:
             'xajax': 'processTraceUser'
             'xajaxargs[]': "<xjxquery><q>email=#{name}</q></xjxquery>"
             'xajaxargs[]': 'email'
           resultkeyword: 'exactness'

        _tel:
          url: "http://reg.jiayuan.com/libs/xajax/reguser.server.php?processUserMobile"
          method: 'POST'
          param:
            'xajax': 'processUserMobile'
            'xajaxargs[]': "<xjxquery><q>mobile=#{name}</q></xjxquery>"
          resultkeyword: 'exactness'
    }
    {
      info:
        _target: '百合网'
        _rule: '手机、邮箱'
        _href: "http://passport.baihe.com/login.jsp"

      req:
        _email:
          url: "http://my.baihe.com/register/emailCheckForXs?email=#{name}"
          method: 'GET'
          resultkeyword: ['state', 1]

        _tel:
          url: "http://my.baihe.com/register/emailCheckForXs?email=#{name}"
          method: 'GET'
          resultkeyword: ['state', 1]
    }
    {
      info:
        _target: '珍爱网'
        _rule: '手机'
        _href: "http://album.zhenai.com/login/login.jsp"

      req:
        _tel:
          url: "http://album.zhenai.com/register/validateMobile3.jsps?mobile=#{name}"
          method: 'GET'
          resultkeyword: 'yes'
    }
    {
      info:
        _target: '红娘网'
        _rule: '手机、邮箱'
        _href: "http://7651.com/login/enter.html"

      req:
        _email:
          url: "http://7651.com/site/ajaxcheckname?username=#{name}"
          method: 'GET'
          resultkeyword: '1'

        _tel:
          url: "http://7651.com/site/cktel"
          method: 'POST'
          param:
            telphone: name
          resultkeyword: ''
    }
    {
      info:
        _target: '知己网'
        _rule: '用户名(20位以内中英文数字，不能为纯数字)'
        _href: "http://www.zhiji.com/"

      req:
        _name:
          url: "http://www.zhiji.com/ajax.asp?checksubmit=yes"
          method: 'POST'
          param:
            action:'checkusername_lay'
            username: name
          resultkeyword: '//window.parent.document.getElementById("Regbtn").disabled=false;'
          format:
            regex: /^[a-zA-Z0-9]*[a-zA-Z]+[a-zA-Z0-9]*$/
            max: 20
            min: 1
    }
    {
      info:
        _target: '绝对100婚恋网'
        _rule: '邮箱'
        _href: "http://www.juedui100.com/"

      req:
        _email:
          url: "http://www.juedui100.com/ajax/identifyEmail?email=#{name}"
          method: 'GET'
          resultkeyword: '0'
    }
    {
      info:
        _target: '江南情缘'
        _rule: '邮箱'
        _href:  "http://www.88999.com/login/Login.aspx"

      req:
        _email:
          url: "http://www.88999.com/Register/checkExistAction.aspx?email=#{name}"
          method: 'GET'
          resultkeyword: '0'
    }
  ]
