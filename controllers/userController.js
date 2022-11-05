const asyncHandler = require("express-async-handler");
const generateToken = require("../config/token");
const User = require("../models/User");
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const {
  handleEmail,
  hanldeName,
  handlePass,
  handleOtp,
} = require("../authentication/otpgenerator");
//creating a new user
const registerUser = asyncHandler(async (req, res) => {
  // const {name,email,password} = req.body
  const email = handleEmail();
  const name = hanldeName();
  const password = handlePass();
  //if all the fields are empty
  if (!name || !email || !password) {
    res.status(400).json({ error: "Please fill in all the input fields" });
  }

  //if email is already registered
  const userExists = await User.findOne({ email });
  if (userExists) {
    res.status(400).json({ error: "User with this email already exists" });
  }

  //salting the password
  var salt = bcrypt.genSaltSync(10);

  //if there is no error while signing up then a create a new user model
  const user = new User({
    name,
    email,
    password: bcrypt.hashSync(password, salt),
  });
  //saving the user
  const result = user.save();

  //if the user gets registered then res the document
  if (result) {
    res.status(201).json({
      _id: user.id,
      name: user.name,
      email: user.email,
      password: user.password,
      token: generateToken(user.id),
    });
  }
  //if the user does not gets registered for any reason
  else {
    res.status(400).json({ error: "Failed to create the user" });
  }
});

//verifying a user
const authUser = asyncHandler(async (req, res) => {
  const { email, password } = req.body;

  //finding the email
  const userFound = await User.findOne({ email });
  //comparing the password
  if (!userFound) {
    res.json({ error: "invalid credentials" });
    return;
  }
  if (bcrypt.compareSync(password, userFound.password)) {
    res.status(201).json({
      _id: userFound.id,
      name: userFound.name,
      email: userFound.email,
      password: userFound.password,
      token: generateToken(userFound.id),
    });
  } else {
    res.status(400).json({ error: "Invalid Credentials" });
  }
});

//forgot password
let otp;
const forgotpass = asyncHandler(async (req, res) => {
  otp = Math.floor(1000 + Math.random() * 9999);
  const { email } = req.body;
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
    subject: "Verification",
    text: `Your ONE TIME PASSWORD(OTP) for reseting your password is ${otp}`,
  };

  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
    } else {
      // console.log('Email sent: ' + info.response);
      res.send(info.response);
    }
  });
});
const forgotPassChange = asyncHandler(async (req, res) => {
  const { password, id } = req.body;

  if (!password) {
    res.status(400).json({ error: "Please enter your new password" });
    return;
  }
  var salt = bcrypt.genSaltSync(10);
  try {
    await User.findByIdAndUpdate(
      { _id:id },
      { password: bcrypt.hashSync(password, salt) },
      (err, result) => {
        if (err) {
          res.status(400).json({ error: "Some error Ocurred" });
          console.log(err)
        }
        else{
            res.status(200).send(result)
        }
      }
    );
  } catch (err) {}
});
const forgotPassOtp = () => {
  return otp;
};
module.exports = {
  registerUser,
  authUser,
  forgotpass,
  forgotPassOtp,
  forgotPassChange,
};
