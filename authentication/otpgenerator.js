const express = require('express')
const nodemailer = require('nodemailer');
const asyncHandler = require('express-async-handler');
const User = require('../models/User');
// const path = require('path')
var email, password, name, otp
const otpGenerator = asyncHandler(async (req, res) => {
    
    email = req.body.email
    name = req.body.name
    password = req.body.password
    
    //generating a random 4 digit number for otp 
    otp = Math.floor(1000 + Math.random() * 9999)

    if (!name || !email || !password) {
      res.status(400).json({ "error": "Please fill in all the input fields" })
      return
    }

    //checking if the user already exists
    const userExists = await User.findOne({ email });
    if (userExists) {
      res.status(400).json({ "error": "User with this email already exists" })
      return
    }
    var transporter = nodemailer.createTransport({
      host: process.env.TRANS_EMAIL,
      port: process.env.TRANS_PORT,
      secure: process.env.BOOL,
      auth: {
        user: process.env.EMAIL,
        pass: process.env.KEY,
      },
    });

    var mailOptions = {
      from: process.env.EMAIL,
      to: email,
      subject: 'Verification',
      // text: `Your ONE TIME PASSWORD(OTP) fro successfull signin is ${otp}`,
      html:`<div class="main" style="font-family:Urbanist,sans-serif;background-color:#007bff;color:#fff;height:40vh;padding:50px"><p style="font-size:2rem">Your<span style="font-weight:700">ONE TIME PASSWORD (OTP)</span>for signin is ${otp} </p></div>`
    };

    transporter.sendMail(mailOptions, function (error, info) {
      if (error) {
        console.log(error);
      } else {
        // console.log('Email sent: ' + info.response);
        res.send(info.response)
      }
  });
})
const handleEmail = () => {
  return email
}
const hanldeName = () => {
  return name
}
const handlePass = () => {
  return password
}
const handleOtp = () => {
  return otp
}
module.exports = { otpGenerator, handleEmail, hanldeName, handlePass, handleOtp }