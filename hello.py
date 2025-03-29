from preswald import text, plotly, connect, get_df, table, query, slider, checkbox, selectbox
import pandas as pd
import plotly.express as px

YEAR = 2025

text("# Housing Market Trends Dashboard")
text("Dashboard by Paul Anderson using Preswald.\n\nData from https://www.kaggle.com/datasets/atharvasoundankar/global-housing-market-analysis-2015-2024.")
text("Allows you to view trends in housing affordability in North American countries and a major countries in the EU.")
text("Showcases the dynamic UI elements `slider`, `checkbox`, and `selectbox` from Preswald.")

# Load the CSV
connect() # Load in all sources, which by default is the sample_csv. In this case it is our housing market dataset.
df = get_df('housing_data')
    
text("## Affordability of Housing in North America and EU")

def north_american_filter():
    sql = "SELECT * FROM housing_data WHERE Country IN ('USA', 'Canada', 'Mexico');"
    na_df = query(sql, "housing_data")
    return na_df

def eu_filter():
    sql = "SELECT * FROM housing_data WHERE Country IN ('France', 'Germany', 'Italy');"
    eu_df = query(sql, "housing_data")
    return eu_df


threshold = int(slider("Range (years to date)", min_val=2, max_val=10, default=5))

choice = selectbox(
    label="Choose Metric",
    options=["Affordability Ratio", "Rent Index", "House Price Index"],
    default="Affordability Ratio"
)

show_eu = checkbox(label="Show EU", default=True)


filtered_df = north_american_filter()

if show_eu:
    filtered_df = pd.concat([north_american_filter(), eu_filter()])

fig = px.line(
    filtered_df[filtered_df["Year"] > YEAR - threshold], 
    x='Year', 
    y=choice, 
    color='Country', 
    title=f"{choice} Over Time"
)

# Style the plot
fig.update_layout(template='plotly_white')

plotly(fig)

text("## Attribution\nIcon from Flaticon.com")

