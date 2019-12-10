var express = require('express');
var router = express.Router();
var oracledb = require('oracledb');
oracledb.autoCommit = true;
var isAuthorized = require('./authLT'); 

var connectionXT;
router.get('/',isAuthorized, function(req, res, next) {
    connectionXT.execute('select MA_SHC,NGAYHETHAN from GS.PassportValid,GS.RESIDENT where GS.PassportValid.CHAPNHAN=1 and GS.PassportValid.MA_SHC=GS.RESIDENT.MSHC',
    (err, result) =>
    {
      if (err) { console.error(err); return; }
      res.render('listPassportValidLT',{'passports':result.rows})
    });
});

router.post('/',isAuthorized, function(req, res) {
    let passport = req.body.passport;
    if (req.body.action == 'Cho gia hạn'){
        connectionXT.execute(`update GS.RESIDENT set NGAYHETHAN=NGAYHETHAN+365 where MSHC='${passport}'`,
        (err, result) =>
        {
        if (err) { console.error(err); return; }
        res.redirect('/LT')
        });
    } else res.redirect('/LT');
});

router.get('/login', function(req, res) {
    res.render('loginLT',{'error':'', isLogin: false })
});
  
router.post('/login', function(req, res, next) {
    let LT = req.body.LT;
    let Pass = req.body.password;
    oracledb.getConnection(
      {
          user          : LT,
          password      : Pass,
          connectString : "localhost/orclpdb"
        },
        function(err, connection)
        {
          if (err) return console.log(err);
          req.session.LoginLT = true;
          connectionXT = connection;
          res.redirect('/LT');
        }
    );
});
router.get('/logout', (req, res) => {
    req.session.LoginLT = false;
    connectionXT.release();
    res.redirect('/')
  })
module.exports = router;