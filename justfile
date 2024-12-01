year := `date +%Y`
lang := "elixir"
day := `date +%-e`

solve:
    cd {{year + '/' + lang}} && {{'elixir day'+day+'.exs'}}
