import sqlite3


def load_data(anime_df, netflix_titles_df, netflix_users_df):
    conn = sqlite3.connect('netflix_analysis.db')
    anime_df.to_sql('anime', conn, if_exists='replace', index=False)
    netflix_titles_df.to_sql('netflix_titles', conn,
                             if_exists='replace', index=False)
    netflix_users_df.to_sql('netflix_users', conn,
                            if_exists='replace', index=False)
    conn.close()
