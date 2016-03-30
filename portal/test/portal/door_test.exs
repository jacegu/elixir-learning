defmodule Portal.DoorTest do
  use ExUnit.Case, async: true

  test "Door.start_link starts an agent" do
    {:ok, pid} = Portal.Door.start_link(:purple)
    assert pid != nil
  end

  test "Door.get returns [] when no data was pushed to the door" do
    {:ok, _ } = Portal.Door.start_link(:red)
    door_data = Portal.Door.get(:red)
    assert door_data == []
  end

  test "Door.get returns the data pushed to the door" do
    {:ok, _ } = Portal.Door.start_link(:red)
    Portal.Door.push(:red, 3)
    Portal.Door.push(:red, 2)
    Portal.Door.push(:red, 1)
    assert Portal.Door.get(:red) == [1, 2, 3]
  end

  test "Door.push pushes data to the door" do
    {:ok, _ } = Portal.Door.start_link(:red)
    Portal.Door.push(:red, :a)
    assert Portal.Door.get(:red) == [:a]
  end

  test "Door.pop pops a value from the door" do
    {:ok, _ } = Portal.Door.start_link(:red)
    Portal.Door.push(:red, :a)
    Portal.Door.push(:red, :b)
    {:ok, poped_value } = Portal.Door.pop(:red)
    assert  poped_value == :b
  end
end
