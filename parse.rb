require 'csv'

def get_all_addresses

rows = CSV.foreach("names.csv", :headers => true).to_a
rows.select!{|row| 
  row["Street"] && row["City"] && row["Zip"]
}
rows.uniq! {|row| [row["Street"], row["City"]] } # TODO hit some api to make this even better too LOL
rows.sort_by! {|row| [row["Street"], row["City"], row["Zip"]]}

rows.map{ |row|
  full_name = row["DESCENDANT First Name"] + " " + row["DESCENDANT Last Name"]
  addr_line1 = row["Street"]
  addr_line2 = row["City"] + " " + row["State Abbreviation"] + " " + row["Zip"]
  country = row["Country"] # they probably can't fly in so late LOL
  if country && country.downcase != 'usa'
    next
    addr_line2 += ", #{country}"
  end
  output = "#{full_name} (and Family)\n#{addr_line1}\n#{addr_line2}\n\n"
  p output
  output
}.compact

end


if __FILE__ == $0
  p get_all_addresses # for debugging
end
