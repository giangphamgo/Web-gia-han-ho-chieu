module.exports = function isAuthorized (req, res, next){
    //if use have not login yet
    if (req.session.LoginLT == true){
        next();
    } else
    res.redirect('/LT/login')
}