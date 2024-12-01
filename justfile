year := `date +%Y`
lang := "elixir"
day := `date +%-e`

# to run other day or year - just day=24 year=2023
solve:
    cd {{year + '/' + lang}} && {{'elixir day'+day+'.exs'}}
