const asyncHandler = require("express-async-handler");
const Symptoms = require("../models/Symptom");

const postSymptoms = asyncHandler(async (req, res) => {
  const { symptoms } = req.body;
  try {
    const symptomsCreate = new Symptoms({
        symptoms
    });
    const result = symptomsCreate.save()
    res.status(200).send(result)

  } catch (error) {
    res.status(400).json({ error: "Some error occurred" });
  }
});
const getAllSymptoms = asyncHandler(async (req, res) => {
  try {
    const symptoms = await Symptoms.find();
    res.status(200).send(symptoms);
  } catch (error) {
    res.status(400).json({ error: "Some error occurred" });
  }
});
module.exports = { getAllSymptoms, postSymptoms };
