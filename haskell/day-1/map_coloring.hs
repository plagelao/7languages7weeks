module Main where
  states = ["Tenesse", "Missisipi", "Alabama", "Georgia", "Florida"]
  borders = [["Missisipi", "Alabama", "Georgia"], ["Tenesse", "Alabama"], ["Tenesse", "Missisipi", "Georgia", "Florida"], ["Tenesse", "Alabama", "Florida"], ["Georgia", "Alabama"]]
  states_and_borders = zip states borders


  paint_map ((state,neighbours):states) colors colored_states
    | states == []    = [paint_state]
    | otherwise       = paint_state:paint_map states colors (paint_state:colored_states)
    where paint_state                   = (state, head colors_not_used_by_neighbours)
          colors_not_used_by_neighbours = [ color | color <- colors, is_a_free_color color]
          is_a_free_color color         = all (\used_color -> used_color /= color) used_colors_in_neighbours
          used_colors_in_neighbours     = [ color | (state, color) <- colored_states, is_neighbour state]
          is_neighbour colored_state    = any (\neighbour -> colored_state == neighbour) neighbours


  color_map colors = paint_map states_and_borders colors []
