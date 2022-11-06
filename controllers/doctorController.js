const asyncHandler = require("express-async-handler");
const generateToken = require("../config/token");
const Doctor = require("../models/Doctor");
const bcrypt = require("bcryptjs");

//registering the doctor

const registerDoctor = asyncHandler(async (req, res) => {
  const {
    name,
    email,
    password,
    image,
    qualification,
    specialization,
    currentLocation,
  } = req.body;

  //if all the fields are empty
  if (!name || !email || !password) {
    res.status(400).json({ error: "Please fill in all the input fields" });
  }

  //salting the password
  var salt = bcrypt.genSaltSync(10);

  //if there is no error while signing up then a create a new user model
  const doctorExists = await Doctor.findOne({ email });
  if (doctorExists) {
    res.status(400).json({ error: "User with this email already exists" });
    return;
  }
  const doctor = new Doctor({
    name,
    email,
    image,
    qualification,
    specialization,
    currentLocation,
    password: bcrypt.hashSync(password, salt),
  });
  //saving the user
  const result = doctor.save();

  //if the user gets registered then res the document
  if (result) {
    res.status(201).json({
      _id: doctor.id,
      name: doctor.name,
      email: doctor.email,
      image: doctor.image,
      qualification: doctor.qualification,
      specialization: doctor.specialization,
      currentLocation: doctor.currentLocation,
      token: generateToken(doctor.id),
    });
  }
  //if the user does not gets registered for any reason
  else {
    res.status(400).json({ error: "Failed to create the user" });
  }
});

//identifying the doctor
const authDoctor = asyncHandler(async (req, res) => {
  const { email, password } = req.body;

  //finding the email
  const doctorFound = await Doctor.findOne({ email });
  //comparing the password
  if (!doctorFound) {
    res.json({ error: "invalid credentials" });
    return;
  }
  if (bcrypt.compareSync(password, doctorFound.password)) {
    res.status(201).json({
      _id: doctorFound.id,
      name: doctorFound.name,
      email: doctorFound.email,
      password: doctorFound.password,
      token: generateToken(doctorFound.id),
    });
  } else {
    res.status(400).json({ error: "Invalid Credentials" });
  }
});

const getAllDoctors = asyncHandler(async (req, res) => {
  try {
    const foundDoctors = await Doctor.find();
    res.status(200).send(foundDoctors);
  } catch (error) {
    res.status(400).json({error:"Some error occurred"})
  }
});

const filterDoctors = async(req,res)=>{
  const {final_prediction} = req.body
  let array = []
  let filter
  for (const [key, value] of Object.entries(final_prediction)) {
    console.log(key)
    filter = await Doctor.find({specialization:key})
    if(filter.length != 0){
      res.status(200).send(filter)
      break
    }
    else{
      continue
    }
  }



  
}
module.exports = { authDoctor, registerDoctor,getAllDoctors,filterDoctors };
