require 'prawn' # gem
require './parse'


Prawn::Document.generate("output.pdf",
 :page_size => "LETTER", # 8.5x10 on its side
 :page_layout => :landscape
) do

  for page in get_all_addresses.each_slice(4)
    text "hello #{page}"
    start_new_page
  end

end


