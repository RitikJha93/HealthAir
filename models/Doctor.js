const mongoose = require('mongoose');

const doctorSchema = mongoose.Schema({
    name:{
        type:String,
        required:true
    },
    email:{
        type:String,
        required:true,
        unique:true
    },
    password:{
        type:String,
        required:true
    },
    image:{
        type:String,
        required:true
    },
    qualification :{
        type:String
    },
    specialization:{
        type:String,
    },
    currentLocation:{
        type:String
    }

},{timestamps:true})


const Doctor = mongoose.model('Doctor',doctorSchema)

module.exports = Doctor