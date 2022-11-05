const express = require('express');
const forgotPassOtpValidator = require('../authentication/forgotPassOtpValidator');
const {otpGenerator,handleEmail,name,email,password} = require('../authentication/otpgenerator');
const otpValidator = require('../authentication/otpValidator');
const { registerUser, authUser,forgotpass,forgotPassChange } = require('../controllers/userController');
const router = express.Router()
//post routing for creating a new user
router.route('/').post(otpGenerator)
//post route for checking otp
router.route('/validate').post(otpValidator,registerUser)
//post routing for authenticating a user
router.post('/login',authUser)
//forgot password
router.post('/forgotPass',forgotpass)
router.post('/forgotPassOtpValidator',forgotPassOtpValidator,)
router.post('/forgotPassChange',forgotPassChange)

module.exports = router
