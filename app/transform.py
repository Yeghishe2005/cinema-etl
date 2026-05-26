import pandas as pd


def transform_data(anime_df, titles_df, users_df):
    # 1. Add Age Group column
    bins = [18, 25, 40, 100]
    labels = ['18-25', '26-40', '40+']
    users_df['age_group'] = pd.cut(
        users_df['age'], bins=bins, labels=labels, include_lowest=True)

    # 2. Add Age Bracket for Analysis C (if you decide to use it later)
    bins_c = [0, 25, 50, 100]
    labels_c = ['Young', 'Adult', 'Senior']
    users_df['age_bracket'] = pd.cut(
        users_df['age'], bins=bins_c, labels=labels_c, right=False)

    return anime_df, titles_df, users_df
