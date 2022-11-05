const mongoose = require('mongoose');

const symptomSchema = mongoose.Schema({
    symptoms:{
        type:Array,
        required:true
    }
},{timestamps:true})


const Symptoms = mongoose.model('Symptoms',symptomSchema)

module.exports = Symptoms