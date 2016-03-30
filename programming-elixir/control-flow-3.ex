defmodule Check do

  def ok!(pattern) do
    case pattern do
      {:ok, data} -> data
      {error_type , error_message} -> raise "#{error_type}: #{error_message}"
    end
  end

  def ok2!({:ok, data}), do: data
  def ok2!({error, message}), do: raise "#{error}: #{message}"

end
