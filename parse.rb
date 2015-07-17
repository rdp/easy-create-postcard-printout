require 'csv'

rows = CSV.foreach("names.csv", :headers => true).to_a
rows.select!{|row| 
  row["Street"] && row["City"] && row["Zip"]
}

for row in rows
  full_name = row["DESCENDANT First Name"] + " " + row["DESCENDANT Last Name"]
  addr1 = row["Street"]
  addr2 = row["City"] + " " + row["State Abbreviation"] + " " + row["Zip"]
  country = row["Country"]
  if country && country.downcase != 'usa'
    p 'using country', country
    addr2 == ", " + row["Country"]
  end
end
