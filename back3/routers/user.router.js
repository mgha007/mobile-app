const router = require('express').Router();
const usercontroller = require('../controller/user.controller');

router.post('/signup',usercontroller.signup);
router.post('/login',usercontroller.login);
router.post('/banuser',usercontroller.banUser);
router.post('/grantadmin',usercontroller.grantadmin);
router.post('/forgotPassword',usercontroller.forgotPassword);
router.post('/resetPassword',usercontroller.resetPassword)
router.post('/getinfo',usercontroller.getinfo);


module.exports=router;