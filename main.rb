require './mars_rover.rb'
require './plateau.rb'

plateau_bounds = ARGF.gets
max_coords = plateau_bounds.split(" ")

plateau = Plateau.new(max_coords[0].to_i, max_coords[1].to_i)
rover = MarsRover.new(plateau)

while !ARGF.eof
  rover_coords_input = ARGF.gets
  break if rover_coords_input == "\n" || rover_coords_input == nil
  cur_x, cur_y, cur_d = rover_coords_input.split(" ")
  rover.set_current_pos(cur_x.to_i, cur_y.to_i, cur_d)

  begin
    rover.follow_commands(ARGF.gets)
  rescue Exception => e
    puts e.message
    break
  end

  rover.print_pos
end
