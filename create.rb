require 'prawn'


Prawn::Document.generate("output.pdf",
 :page_size => "LETTER", # 8.5x10 on its side
 :page_layout => :landscape
) do

  text "hello"



end


