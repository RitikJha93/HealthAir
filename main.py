
import uvicorn
from fastapi import FastAPI
import pickle
import numpy as np
import pandas as pd
from pydantic import BaseModel
from utils import data_dict

app = FastAPI()
pickle_in = open("models/mlp_classifier.pkl", "rb")
classifier=pickle.load(pickle_in)

data = pd.read_csv("dataset/dis_sym_dataset_comb.csv").dropna(axis=1)

diseases = list(set(data['label_dis']))
diseases.sort()

class Symptoms(BaseModel):
    symptoms: str

@app.get('/')
def index():
    return {'message': 'Hi, this is an API to predict diseases given the symptoms'}

@app.post('/predict/')
def predict_disease(symptoms: Symptoms):
    symptoms = symptoms.symptoms
    symptoms = symptoms.split(",")
     
    # creating input data for the models
    input_data = [0] * len(data_dict["symptom_index"])
    for symptom in symptoms:
        index = data_dict["symptom_index"][symptom.capitalize()]
        input_data[index] = 1
         
    # reshaping the input data and converting it
    # into suitable format for model predictions
    input_data = np.array(input_data).reshape(1,-1)
     
    # generating individual outputs
    model_prediction = data_dict["predictions_classes"][classifier.predict(input_data)[0]]
     
    predictions = {
        "final_prediction": model_prediction
    }
    return predictions


@app.post('/predict_prob/')
def predictDisease_prob(symptoms):
    symptoms = symptoms.split(",")

    input_data = [0] * len(data_dict["symptom_index"])
    for symptom in symptoms:
        index = data_dict["symptom_index"][symptom.capitalize()]
        input_data[index] = 1

    input_data = np.array(input_data).reshape(1, -1)

    prediction = classifier.predict_proba(input_data)

    k = 5

    topk = prediction[0].argsort()[-k:][::-1]
    # print(topk)
    top_diseases = {}
    for i in topk:
        print(diseases[i], prediction[0][i]*100)
        if(prediction[0][i]*100):
            top_diseases[diseases[i]] = prediction[0][i]*100

    predictions = {
        "final_prediction": top_diseases
    }
    return predictions

# 5. Run the API with uvicorn
#    Will run on http://127.0.0.1:8000
if __name__ == '__main__':
    uvicorn.run(app, host='127.0.0.1', port=8000)
