var express = require('express');
var router = express.Router();
var oracledb = require('oracledb');
oracledb.autoCommit = true;
var isAuthorized = require('./authXT'); 
/* GET users listing. */
var connectionXT;
router.get('/',isAuthorized, function(req, res, next) {
  connectionXT.execute('select * from GS.Passport',
  (err, result) =>
  {
    if (err) { console.error(err); return; }
    res.render('listPassport',{'passports':result.rows})
  });
});

router.get('/login', function(req, res, next) {
  res.render('loginXT',{'error':'', isLogin: false })
});

router.post('/login', function(req, res, next) {
  let XT = req.body.XT;
  let Pass = req.body.password;
  oracledb.getConnection(
    {
        user          : XT,
        password      : Pass,
        connectString : "localhost/orclpdb"
      },
      function(err, connection)
      {
        if (err) return console.log(err);
        req.session.LoginXT = true;
        connectionXT = connection;
        res.redirect('/XT');
      }
  );
});

router.get('/logout', (req, res) => {
  req.session.LoginXT = false;
  connectionXT.release();
  res.redirect('/')
})

router.get('/:Passport',isAuthorized, function(req, res, next) {
  let passport = req.params.Passport;
  connectionXT.execute(`select * from GS.PASSPORT,GS.RESIDENT where MA_SHC='${passport}' and MSHC='${passport}'`,
  (err, result) =>
  {
    if (err) { console.error(err); return; }
    if (result.rows[0])
      res.render('PassportandResident',{'detail':result.rows[0]})
    else
    res.render('NotFound',{'passport':passport});
  });
});

router.post('/:Passport',isAuthorized, function(req, res, next) {
  let passport = req.params.Passport;
  let p1 = null;
  if (req.body.action == 'Hợp lệ'){
    let name = req.body.name;
    let adress = req.body.adress;
    let gender = req.body.gender;
    let CMND = req.body.CMND;
    let number = req.body.number;
    let mail = req.body.mail;

    p1 = new Promise(
      (resolve, reject) => {
        connectionXT.execute('insert into GS.PASSPORTVALID values (:MA_SHC, :HOVATEN, :DIACHI, :PHAI, :CMND, :DIENTHOAI, :EMAIL, :CHAPNHAN)',
        [passport, name, adress, gender, CMND, number, mail, null],
        { autoCommit: true },
          (err, result) =>
          {
            if (err) { reject(err) }
            resolve(result);
          }
        );
      }
    );
  }
  
  let p2 = new Promise(
    (resolve, reject) => {
      connectionXT.execute(`delete GS.PASSPORT where MA_SHC='${passport}'`,
          (err, result) =>
          {
            if (err) { reject(err) }
            resolve(result);
          });
    }
  );
  if (p1 != null) {
    p1.then(result1 => { 
      p2.then(result2 => { 
        res.redirect('/XT'); 
      }).catch(reason => { 
        res.redirect('/XT'); 
      }); 
    }).catch(reason => { 
      res.redirect('/XT'); 
    });
  } else {
    p2.then(result => { 
      res.redirect('/XT'); 
    }).catch(reason => { 
      res.redirect('/XT'); 
    });
  }
});
module.exports = router;
