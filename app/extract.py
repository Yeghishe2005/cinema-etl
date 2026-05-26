import pandas as pd


def extract_netflix_data():
    df = pd.read_csv(
        r"C:\Users\User\Desktop\anime_sql_project\data\netflix_titles.csv")
    return df


def extract_anime_data():
    df = pd.read_csv(
        r"C:\Users\User\Desktop\anime_sql_project\data\anime.csv")
    return df


def extract_rating_data():
    df = pd.read_csv(
        r"C:\Users\User\Desktop\anime_sql_project\data\netflix_user_behavior_dataset.csv")
    return df
