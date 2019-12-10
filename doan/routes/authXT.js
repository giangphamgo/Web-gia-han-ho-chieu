module.exports = function isAuthorized (req, res, next){
    //if use have not login yet
    if (req.session.LoginXT == true){
        next();
    } else
    res.redirect('/XT/login')
}