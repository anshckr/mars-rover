class MarsRover
  DIRECTIONS = {
    :N => {
      :L => "W",
      :R => "E"
    },
    :W => {
      :L => "S",
      :R => "N"
    },
    :S => {
      :L => "E",
      :R => "W"
    },
    :E => {
      :L => "N",
      :R => "S"
    }
  }

  attr_accessor :position

  def initialize(plateau)
    @plateau = plateau
  end

  def set_current_pos(cur_x, cur_y, cur_d)
    @position = {
      :cur_x => cur_x,
      :cur_y => cur_y,
      :cur_d => cur_d
    }
  end

  def follow_commands(commands)
    commands.split("").each do |i|
      if i == "L" || i == "R"
        rotate(i)
      elsif i == "M"
        move
      else
        raise "Invalid Move : #{i}"
      end
    end
  end

  def print_pos
    puts @position[:cur_x].to_s + " " + @position[:cur_y].to_s + " " + @position[:cur_d]
  end

  private

  def move
    displacement = determine_displacement
    new_x = @position[:cur_x] + displacement[:x]
    new_y = @position[:cur_y] + displacement[:y]

    if new_x <= @plateau.max_x && new_y <= @plateau.max_y && new_x >= 0 && new_y >= 0
      @position[:cur_x] = new_x
      @position[:cur_y] = new_y
    else
      raise Exception.new("Out of bounds")
    end
  end

  def rotate(rotate_dir)
    @position[:cur_d] = DIRECTIONS[@position[:cur_d].to_sym][rotate_dir.to_sym]
  end

  def determine_displacement
    x = 0
    y = 0
    case @position[:cur_d]
    when "N"
      x = 0
      y = 1
    when "S"
      x = 0
      y = -1
    when "E"
      x = 1
      y = 0
    when "W"
      x = -1
      y = 0
    end
    return { :x => x, :y => y }
  end
end
