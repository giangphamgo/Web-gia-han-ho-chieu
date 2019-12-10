var express = require('express');
var router = express.Router();
var oracledb = require('oracledb');
oracledb.autoCommit = true;
var isAuthorized = require('./authXD'); 

var connectionXT;
router.get('/',isAuthorized, function(req, res, next) {
    connectionXT.execute('select * from GS.PassportValid where CHAPNHAN is null',
    (err, result) =>
    {
      if (err) { console.error(err); return; }
      res.render('listPassportValid',{'passports':result.rows})
    });
});

router.post('/',isAuthorized, function(req, res) {
    let passport = req.body.passport;
    let accept;
    if (req.body.action == 'Đồng ý')
        accept = 1;
    else
        accept = 0;
    connectionXT.execute(`update GS.PassportValid set CHAPNHAN=${accept} where MA_SHC='${passport}'`,
    (err, result) =>
    {
      if (err) { console.error(err); return; }
      res.redirect('/XD')
    });
});

router.get('/login', function(req, res) {
    res.render('loginXD',{'error':'', isLogin: false })
});
  
router.post('/login', function(req, res, next) {
    let XD = req.body.XD;
    let Pass = req.body.password;
    oracledb.getConnection(
      {
          user          : XD,
          password      : Pass,
          connectString : "localhost/orclpdb"
        },
        function(err, connection)
        {
          if (err) return console.log(err);
          req.session.LoginXD = true;
          connectionXT = connection;
          res.redirect('/XD');
        }
    );
});
router.get('/logout', (req, res) => {
    req.session.LoginXD = false;
    connectionXT.release();
    res.redirect('/')
  })
module.exports = router;