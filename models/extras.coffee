module.exports = extras =
  targets: ['芒果网', '优酷', '精品网', '58团购']
  category: 'extra'
  name: '其他'
  rules: [
    '手机、邮箱、用户ID(6~12位，字母或数字)'
    '手机、邮箱、昵称(2个中文或4个字符)'
    '邮箱、用户ID(字母开头，5~12位，由英文，数字，"－"，"_"构成)'
    '邮箱、用户名(4~20位，由汉字、数字、字母和"_"组成)'
  ]
  link_urls:[
    "http://www.mangocity.com/mbrweb/login/init.action"
    "http://www.youku.com/user_login/"
    "http://my.sg.com.cn/"
    "http://passport.58.com/login"
  ]
  validate_urls:{
    emails:
      "http://www.mangocity.com/mbrweb/validate/validateVerifyCode.action?verifyCode=0297&countryMobileNo=86&emailNo=#{name}"
      "http://www.youku.com/user/chk_mail?__rt=1&__ro=&key=email&vo=#{name}"
    tel_name:
      "http://www.mangocity.com/mbrweb/validate/validateVerifyCode.action?verifyCode=0297&mobileNo=#{name}"
      "http://www.youku.com/user/chkAccount?__rt=1&__ro=&inputs=#{name}"
    "http://reg.sg.com.cn/action.php?ac=check_unique"
    "http://passport.58.com/ajax"
  }

  check:[
    (i, name, cb)->
        base_url = validate_urls_base[0]
        if isTel name
          url = "#{base_url}&mobileNo=#{name}"
        else if isEmail name
          url = "#{base_url}&countryMobileNo=86&emailNo=#{name}"
        else
          if !formatValidation name, /^[a-zA-Z0-9]*$/, 12, 6
            return cb 'invalid'
          url = "#{base_url}&webId=#{name}"
        request.get url, (e, r, data)->
          return cb data == '1'

    (i, name, cb)->
        base_url = validate_urls_base[1]
        if isTel name
          url = "#{base_url}/chkAccount?__rt=1&__ro=&inputs=#{name}"
        else if isEmail name
          url = "#{base_url}/chk_mail?__rt=1&__ro=&key=email&vo=#{name}"
        else
          if !formatValidation name, /^[\u4E00-\u9FFFa-zA-Z0-9_\-]*$/, 30, 4
            return cb 'invalid'
          url = "#{base_url}/chk/?__rt=1&__ro=&key=username&vo=#{name}"
        request.get url, (e, r, data)->
          return cb data == '1'

    (i, name, cb)->
        base_url = validate_urls_base[2]
        url = "#{base_url}&type=users_name&value=#{name}"
        if isEmail name
          url = "#{base_url}&type=users_email&value=#{name}"
        else if !formatValidation name, /^[a-zA-Z][a-zA-Z0-9\-_]*$/, 12, 5
          return cb 'invalid'
        request.get url, (e, r, data)->
          return cb data == '1'

    (i, name, cb)->
        base_url = validate_urls_base[3]
        url = "#{base_url}/checknickname?id=8669&nickname=#{name}"
        if isEmail name
          url = "#{base_url}/checkemail?id=421&email=#{name}"
        else
          if !formatValidation name, /^[\u4E00-\u9FFFa-zA-Z0-9_]*$/, 20, 4
            return cb 'invalid'

        request.get url, (e, r, data)->
          return cb data == '1'
  ]
