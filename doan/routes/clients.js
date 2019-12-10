var express = require('express');
var router = express.Router();
var oracledb = require('oracledb');
/* GET users listing. */
router.get('/', function(req, res, next) {
    res.render('formClient')
});
router.post('/', function(req, res, next) {
    let name = req.body.name;
    let address = req.body.address;
    let gender = req.body.gender;
    let CMND = req.body.CMND;
    let phone = req.body.phone;
    let mail = req.body.mail;
    let passport = req.body.passport;
    oracledb.getConnection(
        {
            user          : "nguoidung",
            password      : "123456",
            connectString : "localhost/orclpdb"
          },
          function(err, connection)
          {
            if (err) { console.error(err); return; }
            connection.execute ('insert into GS.PASSPORT values(:MA_SHC, :HOVATEN, :DIACHI, :PHAI, :CMND, :DIENTHOAI, :EMAIL)',
                [passport, name, address, gender, CMND, phone, mail],
                { autoCommit: true },
                (err, result => {
                    if (err) {
                        console.error("insert2",err.message); 
                        callback(err.message)
                    } else {
                        console.log(result); 
                        if (result == null)
                            res.render('formClientSuccess');
                        else
                            res.render('formClientError');
                    }
                    connection.release();
                }));
        }
    );
});
module.exports = router;
