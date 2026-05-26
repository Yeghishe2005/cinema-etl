from extract import extract_netflix_data, extract_anime_data, extract_rating_data
from transform import transform_data
from load import load_data


def run_etl():
    # Extract
    anime = extract_anime_data()
    titles = extract_netflix_data()
    users = extract_rating_data()

    # Transform
    anime, titles, users = transform_data(anime, titles, users)

    # Load
    load_data(anime, titles, users)
    print("ETL process completed successfully.")


if __name__ == "__main__":
    run_etl()
