namechk = require '../lib/namechk'
async = require 'async'

chkall = (name, cb)->
  return cb 'error' if !name
  alldata=[]
  async.each namechk.categories, (cate, cb1)->
    async.forEachOf cate.urls, (url, index, cb2)->
      # console.log cate.category
      try
        cate.check index, name, (ret)->
          console.log 'ret',cate.category,index,ret
          alldata.push {name:cate.targets[index], url: cate.urls[index], category: cate.category, ret:ret}
          return cb2 null
      catch err
        console.log "check error:",url, name,err
        return cb2 null
    , (err) ->
      console.log "error:", err if err
      # console.log 'cb2:',cate.category
      cb1 null
  , (err) ->
    console.log "cb error:",err if err
    # console.log 'cb1:',err, alldata.length
    cb null, alldata


module.exports.chkall = chkall
#
# chkall 'yiyangzhi111', (err, alldata)->
#   console.log err, alldata
