
prefix = fn(prefix) -> (fn(string) -> "#{prefix} #{string}" end) end
mr = prefix.("Mr.")
IO.puts mr.("Acero")

