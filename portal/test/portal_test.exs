defmodule PortalTest do
  use ExUnit.Case

  test "Portal.shoot creates a door" do
    Portal.shoot(:purple)
    assert Portal.Door.get(:purple) == []
  end

  test "Portal.transfer creates a transfer betwee two doors" do
    Portal.shoot(:black)
    Portal.shoot(:white)

    portal = Portal.transfer(:black, :white, [1, 2])
    assert portal.left == :black
    assert portal.right == :white
    assert Portal.Door.get(:black) == [2, 1]
  end

  test "Portal.push_right pushes data between the two doors" do
    Portal.shoot(:green)
    Portal.shoot(:yellow)
    portal = Portal.transfer(:green, :yellow, [1, 2, 3, 4])

    Portal.push_right(portal)
    Portal.push_right(portal)
    assert assert Portal.Door.get(:green) == [2, 1]
    assert assert Portal.Door.get(:yellow) == [3, 4]
  end

  test "Portal.push_left pushes data between the two doors" do
    Portal.shoot(:grey)
    Portal.shoot(:brown)
    portal = Portal.transfer(:grey, :brown, [:a, :b, :c])

    Portal.push_right(portal)
    Portal.push_right(portal)
    Portal.push_right(portal)
    assert assert Portal.Door.get(:grey) == []
    assert assert Portal.Door.get(:brown) == [:a, :b, :c]

    Portal.push_left(portal)
    Portal.push_left(portal)
    assert assert Portal.Door.get(:grey) == [:b, :a]
    assert assert Portal.Door.get(:brown) == [:c]
  end

end
