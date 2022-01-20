from app.models import schemas
import pickle
import pandas as pd
import numpy as np

address = open("./app/config/RandomForest.pkl", "rb")
model = pickle.load(address)


def prediction(request: schemas.Feature):
    prediction = model.predict(
        pd.DataFrame(
            columns=["make", "model", "city", "year", "km", "type", "cc", "mode"],
            data=np.array(
                [
                    request.brand,
                    request.model,
                    request.city,
                    request.year,
                    request.km,
                    request.fuel_type,
                    request.cc,
                    request.mode,
                ]
            ).reshape(1, 8),
        )
    )
    return str(np.round(prediction[0], 2))
