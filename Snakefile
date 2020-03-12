from os.path import join as j

# Data feed from Tableau. Raw data is from JHU CSSE GitHub.
TABLEAU_TS = 'data_sources/tableau/tableau_ts.csv'

# Location data pulled from tableau/jhu dataset.
COORDINATES = 'output/location/coordinates.csv'

# Data file from Our World in Data. Directly from WHO
OWID_TS = 'data_sources/our_world_in_data/owid_ts.csv'

# Population data from Worldbank
WB_DATA_DIR = "data_sources/worldbank_population_data"
WB_POP_RAW = j(WB_DATA_DIR, 'API_SP.POP.TOTL_DS2_en_csv_v2_821007.csv')
WB_META = j(WB_DATA_DIR, 'Metadata_Country_API_SP.POP.TOTL_DS2_en_csv_v2_821007.csv')
WB_RAW = j(WB_DATA_DIR, 'wb_raw.csv')

# Population data cleaning and matching with JHU data
POP_ADDITION = j(WB_DATA_DIR, 'pop_addition.csv')
POP_CONVERSION = j(WB_DATA_DIR, 'pop_conversion.csv')
POP_CLEANED_CSV = j(WB_DATA_DIR, 'pop.csv')

# Final json file for the visualization
CNTRY_STAT_JSON = 'cntry_stat.json'

include: "snakemake_tableau.smk"
include: "snakemake_owid.smk"
#include: "data_sources/our_world_in_data/Snakefile"
#include: "data_sources/worldbank_population_data/Snakefile"

rule all:
    input: COORDINATES # CNTRY_STAT_JSON

rule extract_coordinates:
    input: TABLEAU_TS
    output: COORDINATES
    script: "scripts/extract_coordinates.py"

# rule combine_ts:
    # input: CONFIRMED_TS, DEATHS_TS, RECOVERED_TS
    # output: COMBINED_TS
    # script: "scripts/combine_ts.py"

# rule merge_ts_and_pop_data:
    # input: COMBINED, POP_CLEANED_CSV
    # output: CNTRY_STAT_JSON
    # script: "scripts/merge_ts_and_pop_data.py"
