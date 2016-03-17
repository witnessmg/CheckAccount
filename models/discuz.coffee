module.exports = discuzs =

  category: 'discuz'

  name: 'Discuz论坛'

  agent: ''

  cid: 5

  members:
    {
      info:
        _target: '社区动力'
        _rule: '邮箱、用户ID(3~15个字符)'
        _href: "http://www.discuz.net/forum.php"

      req:
        _email:

          method: 'GET'
          options:
            url: "http://www.discuz.net/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
          keyword: 'succeed'

        _name:

          method: 'GET'
          options:
            url: "http://www.discuz.net/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{encodeURIComponent name}"
          keyword: 'succeed'
          format:
            regex: ''
            max: 15
            min: 3

    }
    {
      info:

        _target: '社区门户'
        _rule: '邮箱、用户ID(3~15个字符)'
        _href: "http://lasg.cn/"

      req:
        _email:

          method: 'GET'
          options:
            url:"http://bbs.lasg.ac.cn/bbs/ajax.php?inajax=1&action=checkemail&email=#{name}"
          keyword: 'succeed'

        _name:

          method: 'GET'
          options:
            url: "http://bbs.lasg.ac.cn/bbs/ajax.php?inajax=1&action=checkusername&username=#{encodeURIComponent name}"
          keyword: 'succeed'
          format:
            regex: ''
            max: 15
            min: 3
    }
    {
      info:

        _target: '站帮网'
        _rule: '邮箱、用户ID(3~15个字符)'
        _href: "http://bbs.zb7.com/"

      req:
        _email:

          method: 'GET'
          options:
            url: "http://www.zb7.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
          keyword: 'succeed'

        _name:

          method: 'GET'
          options:
            url: "http://www.zb7.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{name}"
          keyword: 'succeed'
          format:
            regex: ''
            max: 15
            min: 3

    }
    {!!!!
      info:

        _target: '若人论坛'
        _rule: '邮箱、用户ID(3~15个字符)'
        _href: "http://bbs.ruoren.com/"

      req:
        _email:

          url: "http://bbs.ruoren.com/public/sendmail"
          method: 'POST'
          resultkeyword: 'succeed'

        _name:
          url: "http://bbs.ruoren.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{encodeURIComponent name}"
          method: 'GET'
          resultkeyword: 'succeed'
          format:
            regex: ''
            max: 15
            min: 3

    }
    {
      info:

        _target: '魔客吧'
        _rule: '邮箱、用户ID(3~15个字符)'
        _href: "http://www.moke8.com/"

      req:
        _email:

          method: 'GET'
          options:
            url: "http://www.moke8.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
          keyword: 'succeed'

        _name:

          method: 'GET'
          options:
            url: "http://www.moke8.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{encodeURIComponent name}"
          keyword: 'succeed'
          format:
            regex: ''
            max: 15
            min: 3

    }
