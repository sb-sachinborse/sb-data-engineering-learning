import pandas as pd


def transform_data(json_data):
    df = pd.json_normalize(json_data)

    #select & rename columns 
    df = df[[
        "id",
        "name",
        "username",
        "email",
        "address.city",
        "phone",
        "company.name"
    ]]

    df.rename(columns = {
        "address.city": "city",
        "company.name":"company.name"
    }, inplace=True)

    return df