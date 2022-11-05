const express = require('express')
const dotenv = require('dotenv')
const connectDB = require('./db/db');
const userRoutes = require('./routes/userRoutes')
const doctorRoutes = require('./routes/doctorRoutes')
const fileUpload = require('express-fileupload')

dotenv.config()
const PORT = process.env.PORT || 5000

const app = express()
app.use(express.json())
connectDB()
app.use(fileUpload({
    useTempFiles:true
}))
app.use('/api/user',userRoutes)
app.use('/api/doctor',doctorRoutes)

app.get('/',(req,res)=>{
    res,send("Hello World")
})
app.listen(PORT,()=>{
    console.log('server started successfully')
})