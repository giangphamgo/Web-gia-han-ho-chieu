module.exports = function isAuthorized (req, res, next){
    //if use have not login yet
    if (req.session.LoginXD == true){
        next();
    } else
    res.redirect('/XD/login')
}