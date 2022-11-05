const express = require('express')
const nodemailer = require('nodemailer');
const path = require('path')
const {handleEmail,hanldeName,handlePass,handleOtp} = require('./otpgenerator')
const otpValidator = (req,res,next)=>{

    //fetching the generated otp
    const otp = handleOtp()

    //user otp
    const {userOTP} = req.body;

    //if the field remains empty
    if(!userOTP){
        res.status(400).json({error:"Please enter the otp"});
        return
    }

    //if the otp sent to mail and generated otp does not match
    if(userOTP != otp){
        res.status(400).json({error:"OTP does not match"})
        return
    }

    //if all the case passes
    try {
        //if the otp matches the calling registerUser
        if(userOTP == otp){
            next()
        }
    } catch (error) {
        res.status(400).json({error:"some error occurred"})
        console.log(error);
    }
}
module.exports = otpValidator