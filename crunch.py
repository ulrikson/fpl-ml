import pandas as pd
from datetime import datetime, timedelta, date
import time

PLAYER_URL = "https://raw.githubusercontent.com/vaastav/Fantasy-Premier-League/master/data/2020-21/gws/merged_gw.csv"
columns = []
df = pd.read_csv(PLAYER_URL)

difficult_teams = [5, 9, 11, 12, 13, 17]  # big six
df["difficult"] = df["opponent_team"].apply(lambda x: 1 if x in difficult_teams else 0)
df["kickoff_time"] = pd.to_datetime(df["kickoff_time"]).dt.date
df["was_home"] = df["was_home"].apply(lambda x: 1 if x else 0)


def form(player, kickoff):
    is_player = df["element"] == player
    last_thirty_days = df["kickoff_time"] >= kickoff - timedelta(days=30)
    df_player = df[is_player & last_thirty_days]
    points = df_player["total_points"].sum()
    games = df_player[df_player["minutes"] > 0].count()[0]
    form = points / games if games > 0 else 0
    return form


start = time.time()
df["form"] = df.apply(lambda x: form(x["element"], x["kickoff_time"]), axis=1)
end = time.time()
print(end - start)

df.to_csv("fpl.csv", index=False)
