defmodule GameOfLifeTest do
  use ExUnit.Case, async: true

  test "it produces a grid around a point" do
    point = {0, 0}
    grid = GameOfLife.grid_for(point)
    assert grid == HashSet.new([{1, 1},  {1, 0},  {1, -1},
                                {0, 1},  {0, 0},  {0, -1},
                                {-1, 1}, {-1, 0}, {-1, -1}])
  end

  test "a cell lives on if it has two neighbors" do
    point = {0, 0}
    world = HashSet.new([{1, 1}, {-1, -1}, {0, 0}])
    assert GameOfLife.alive_next_generation?(3, world, point)
  end

  test "a cell lives on if it has three neighbors" do
    point = {0, 0}
    world = HashSet.new([{1, 1}, {-1, 0}, {-1, -1}, {0, 0}])
    assert GameOfLife.alive_next_generation?(4, world, point)
  end

  test "a cell dies if it has 1 neighbor" do
    point = {0, 0}
    world = HashSet.new([{1, 1}, {0, 0}])
    assert not GameOfLife.alive_next_generation?(2, world, point)
  end

  test "a cell dies if it has more than 3 neighbors" do
    point = {0, 0}
    world = HashSet.new([{1, 1}, {-1, 0}, {1, 0}, {-1, -1}, {0, 0}])
    assert not GameOfLife.alive_next_generation?(5, world, point)
  end

  test "a dead cell comes to life with exactly three neighbors" do
    point = {0, 0}
    world = HashSet.new([{1, 1}, {-1, 0}, {0, -1}])
    assert GameOfLife.alive_next_generation?(3, world, point)
  end

  test "a dead cell remains dead with two neighbors" do
    point = {0, 0}
    world = HashSet.new([{1, 1}, {-1, -1}])
    assert not GameOfLife.alive_next_generation?(2, world, point)
  end

  test "a dead cell remains dead with four neighbors" do
    point = {0, 0}
    world = HashSet.new([{1, 1}, {-1, -1}, {-1, 0}, {0, -1}])
    assert not GameOfLife.alive_next_generation?(4, world, point)
  end

  test "it generates a next world" do
    world = HashSet.new([{-1, 0}, {0, 0}, {1, 0}])
    next_world = GameOfLife.next_world(world)
    assert Set.member?(next_world, {0, 1})
    assert Set.member?(next_world, {0, 0})
    assert Set.member?(next_world, {0, -1})
  end
end
