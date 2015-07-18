require 'prawn' # gem
require './parse'

Prawn::Document.generate("output.pdf",
 :page_size => "LETTER", # 8.5x11 on its side  612.00 x 792.00 but flipped since we're landscape :)
 :page_layout => :landscape,
 :margin => 0 # let me do my own margins :) XXXX do I want to? hrm...
) do
  width = 792
  height = 612

  return_address = "John Pack Family Association\n691 W 1150 S\nProvo, UT 84601"
  # assume a margin of 20 all around so it can be printable
  # 0,0 is bottom left, like a grid
  middle_line = (height-20)/2 - 10 # - 10 I think it needs for the "first line" which gets written *up* from the current location [?]
  middle_row = (width-20)/2 + 20 # + 20 just to meet my criteria possibly :|
  top_line = height - 20*2 - 10 
  left_row = 20
  start_locs  = [[left_row, middle_line], [left_row, top_line], [middle_row, middle_line], [middle_row, top_line]]
   
  for page in get_all_addresses.each_slice(4)
    #stroke_axis # shows a ruler for formatting examination :)
    page.each_with_index { |address, idx|
      #move_to start_locs[idx]
      p 'drawing at', start_locs[idx], address
      x = start_locs[idx][0]
      y = start_locs[idx][1]
      quarter_width = (width - 40)/4
      quarter_height = (height - 40)/4
      text_box return_address, :at => [x, y]
      address_to_x = x + quarter_width/2 # don't want it going too far right...it needs a lot of space :)
      half_width = (width - 20*2)/2
      address_to_width = half_width - quarter_width/2 - 20 # - 20 just to force some margin between them for cutting purposes :)
      text_box address, :at => [address_to_x, y - quarter_height], :width => address_to_width
    }
    start_new_page
  end

end

p "did #{get_all_addresses.size} entries"
