require 'prawn' # gem
require './parse'



Prawn::Document.generate("output.pdf",
 :page_size => "LETTER", # 8.5x10 on its side  612.00 x 792.00 but flipped since we're landscape :)
 :page_layout => :landscape
) do
  width = 792
  height = 612

  # assume a margin of 20 all around so it can be printable
  # 0,0 is bottom left, like a grid
  middle_line = (612-20)/2
  middle_row = (792-20)/2
  top_line = 612 - 20*2
  left_row = 20
  start_locs  = [[left_row, middle_line], [left_row, top_line], [middle_row, middle_line], [middle_row, top_line]]
   
  for page in get_all_addresses.each_slice(4)
    page.each_with_index { |address, idx|
      #move_to start_locs[idx]
      p 'drawing at', start_locs[idx], address
      draw_text address.split, :at => start_locs[idx]
    }
    start_new_page
  end

end


