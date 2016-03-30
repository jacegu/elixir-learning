defmodule Portal do
  use Application

  defstruct [:left, :right]

  @doc """
  Starts transfering `data` from `left` to `right`.
  """
  def transfer(left, right, data) do
    for item <- data do
      Portal.Door.push(left, item)
    end

    %Portal{left: left, right: right}
  end

  @doc """
  Pushes data to the right in the given `portal`.
  """
  def push_right(portal) do
    push_between_doors(portal.left, portal.right)
    portal
  end

  @doc """
  Pushes data to the left in the given `portal`.
  """
  def push_left(portal) do
    push_between_doors(portal.right, portal.left)
    portal
  end

  defp push_between_doors(source, destiny) do
    case Portal.Door.pop(source) do
      :error   -> :ok
      {:ok, h} -> Portal.Door.push(destiny, h)
    end
  end

  @doc """
  Shoots a new door with the given `color`.
  """
  def shoot(color) do
    Supervisor.start_child(Portal.Supervisor, [color])
  end


  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Portal.Door, []),
    ]

    opts = [strategy: :simple_one_for_one, name: Portal.Supervisor]
    Supervisor.start_link(children, opts)
  end


  defimpl Inspect, for: Portal do
    def inspect(%Portal{left: left, right: right}, _) do
      left_door  = inspect(left)
      right_door = inspect(right)

      left_data  = inspect(Enum.reverse(Portal.Door.get(left)))
      right_data = inspect(Portal.Door.get(right))

      max = max(String.length(left_door), String.length(left_data))

      """
      #Portal<
      #{String.rjust(left_door, max)} <=> #{right_door}
      #{String.rjust(left_data, max)} <=> #{right_data}
      >
      """
    end
  end
end
