const jwt = require('jsonwebtoken')

//generating a new token and assigning to user on signup
const generateToken = (id) =>{
    return jwt.sign({id},process.env.JWT_SECRET,{expiresIn:"2d"})
}

module.exports = generateToken