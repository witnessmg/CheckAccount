module.exports = discuzs =
  targets: ['社区动力', '社区门户', '站帮网', '若人论坛', '魔客吧']
  category: 'discuz'
  name: 'Discuz论坛'
  agent: ''
  cid: 5
  rules: [
    '邮箱、用户ID(3~15个字符)'
    '邮箱、用户ID(3~15个字符)'
    '邮箱、用户ID(3~15个字符)'
    '邮箱、用户ID(3~15个字符)'
    '邮箱、用户ID(3~15个字符)'
  ]
  urls:[
    "http://www.discuz.net/forum.php"
    "http://lasg.cn/"
    "http://bbs.zb7.com/"
    "http://bbs.ruoren.com/"
    "http://www.moke8.com/"
  ]
  validate_urls:{
    email:[
      "http://www.discuz.net/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
      "http://bbs.lasg.ac.cn/bbs/ajax.php?inajax=1&action=checkemail&email=#{name}"
      "http://www.zb7.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
      "http://bbs.ruoren.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
      "http://www.moke8.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
    ]
    tel: [
      ""
      ""
      ""
      ""
      ""
    ]
    name: [
      "http://www.discuz.net/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{encodeURIComponent name}"
      "http://bbs.lasg.ac.cn/bbs/ajax.php?inajax=1&action=checkusername&username=#{encodeURIComponent name}"
      "http://www.zb7.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkemail&email=#{name}"
      "http://bbs.ruoren.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{encodeURIComponent name}"
      "http://www.moke8.com/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=#{encodeURIComponent name}"
    ]

  }
  format: [
    {
      regex: ''
      max: 15
      min: 3
    }
    {
      regex: ''
      max: 15
      min: 3
    }
    {
      regex: ''
      max: 15
      min: 3
    }
    {
      regex: ''
      max: 15
      min: 3
    }
    {
      regex: ''
      max: 15
      min: 3
    }
  ]
  check:[
    (name ,cb) ->
      request.get url, (e, r, data)->
        return cb data.indexOf('succeed') != -1
    (name, cb) ->
      request.get url, (e, r, data)->
        return cb data?.indexOf?('succeed') != -1
    (name, cb) ->
      request.get url, (e, r, data)->
        return cb data.indexOf('succeed') != -1
    (name, cb) ->
      request.get url, (e, r, data)->
        return cb data.indexOf('succeed') != -1
    (name, cb) ->
      request.get url, (e, r, data)->
        return cb data.indexOf('succeed') != -1
  ]
