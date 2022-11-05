const asyncHandler = require('express-async-handler')
const generateToken = require('../config/token');
const Doctor = require('../models/Doctor');

//registering the doctor

const registerDoctor = asyncHandler(async(req,res)=>{
    const {name,email,password,image,qualification,specialization,currentLocation} = req.body

    //if all the fields are empty
    if(!name || !email || !password){
        res.status(400).json({"error":"Please fill in all the input fields"})
    }

    //salting the password 
    var salt = bcrypt.genSaltSync(10);

    //if there is no error while signing up then a create a new user model
    const doctor = new Doctor({
        name,email,image,qualification,specialization,currentLocation,
        password:bcrypt.hashSync(password, salt),
    })
    //saving the user
    const result = doctor.save()

    //if the user gets registered then res the document
    if(result){
        res.status(201).json({
            _id:doctor.id,
            name:doctor.name,
            email:doctor.email,
            password:doctor.password,
            token : generateToken(doctor.id)
        })
    }
    //if the user does not gets registered for any reason
    else{
        res.status(400).json({"error":"Failed to create the user"})
    }
})

//identifying the doctor
const authDoctor = asyncHandler(async(req,res)=>{
    const {email,password} = req.body;

    //finding the email
    const doctorFound = await Doctor.findOne({email});
    //comparing the password
    if(!doctorFound){
        res.json({"error":"invalid credentials"})
        return
    }
    if(bcrypt.compareSync(password,doctorFound.password)){
        res.status(201).json({
            _id:doctorFound.id,
            name:doctorFound.name,
            email:doctorFound.email,
            password:doctorFound.password,
            token : generateToken(doctorFound.id)
        })
    }
    else{
        res.status(400).json({"error":"Invalid Credentials"})
    }
})

module.exports = {authDoctor,registerDoctor}