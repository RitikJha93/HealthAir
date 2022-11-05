const express = require('express');
const { getAllSymptoms,postSymptoms } = require('../controllers/symptomController');
const router = express.Router()

router.route('/getAllSymptoms').get(getAllSymptoms)
router.route('/postSymptoms').post(postSymptoms)
module.exports = router