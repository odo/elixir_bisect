defmodule Bisect.List do

@behaviour Bisect.Source

def init(list), do: list

def first_index(_), do: 0

def last_index(list), do: length(list) - 1

def next_index(previous_index, list), do: min(last_index(list), previous_index + 1)

def previous_index(index_candidate, _), do: max(index_candidate - 1, 0)

def value(index, list) when index > (length(list) - 1), do: :head
def value(index, list), do: Enum.at(list, index)

end
