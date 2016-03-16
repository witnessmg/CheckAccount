express = require('express')
router = express.Router()
namechk = require '../lib/namechk'


router.get '/', (req, res, next)->
  res.locals.messages=
    error: ''
    info: 'info'
  res.locals.checkname = req.query.checkname if req.query.checkname
  namechk.allchks (allchks)->
    res.render 'vid_namechk',
      allchks: allchks

router.post '/', (req, res, next)->
  res.locals.messages=
    error: ''
    info: 'info'
  namechk.check Number(req.body.checkid), req.body.checkname, (r)->
    if r == 'invalid'
      res.end '-1'
    else
      res.end if r then '1' else '0'        # 1 -> not exist , 0 -> exist

module.exports = router
