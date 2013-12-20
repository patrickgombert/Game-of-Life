defmodule GameOfLife do
  def grid_for({x_point, y_point}), do: HashSet.new(Enum.flat_map((-1..1), &(Enum.map((-1..1), fn(y) -> {x_point - &1, y_point - y} end))))
  def alive_next_generation?(3, _, _), do: true
  def alive_next_generation?(4, world, point), do: Set.member?(world, point)
  def alive_next_generation?(_, _, _), do: false
  def next_world(world), do: HashSet.new(Enum.reject(Enum.reduce(world, HashSet.new, &(Set.union(&2, grid_for(&1)))), &(not alive_next_generation?(Enum.count(Set.intersection(world, grid_for(&1))), world, &1))))
end
