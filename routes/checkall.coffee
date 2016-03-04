express = require('express')
router = express.Router()
chkall = require '../lib/allchk'
router.get '/', (req, res, next) ->
  if !req.query.name
    return res.status(400).send """
          {"err":"must input the name to check"}
          """
  chkall.chkall req.query.name, (err, data) ->
    return res.send {err:err} if err
    return res.send data

module.exports = router
