defmodule Bisect do

  def find(key, callback_module, start_args) do
    state = callback_module.init(start_args)
    case find(callback_module.first_index(state), callback_module.last_index(state), key, callback_module, state) do
      {index , key_found} when key_found < key ->
        next_index = callback_module.next_index(index, state)
        {next_index, callback_module.value(next_index, state)}
      {index, key_found} ->
        {index, key_found}
    end
  end

  defp find(min_index, max_index, _, callback_module, state) when max_index < min_index do
    scan_left(min_index, callback_module.value(min_index, state), callback_module, state)
  end
  defp find(same_index, same_index, _, callback_module, state) do
    {same_index, callback_module.value(same_index, state)}
  end
  defp find(min_index, max_index, key, callback_module, state) do
    middle_index_calc = round(Float.floor((max_index - min_index) / 2)) + min_index
    middle_index = callback_module.next_index(middle_index_calc, state)
    case callback_module.value(middle_index, state) do
      ^key ->
        scan_right(middle_index, key, callback_module, state)
      middle_value when middle_value > key ->
        find(min_index, callback_module.previous_index(middle_index, state), key, callback_module, state)
      middle_value when middle_value < key ->
        find(callback_module.next_index(middle_index + 1, state), max_index, key, callback_module, state)
    end
  end

  defp scan_right(index, key, callback_module, state) do
    with next_index when next_index != index <- callback_module.next_index(index, state),
                                        ^key <- callback_module.value(next_index, state)
    do
       scan_right(next_index, key, callback_module, state)
    else
      _ -> {index, key}
    end
  end

  defp scan_left(index, key, callback_module, state) do
    with next_index when next_index != index <- callback_module.previous_index(index, state),
                                        ^key <- callback_module.value(next_index, state)
    do
       scan_left(next_index, key, callback_module, state)
    else
      _ -> {index, key}
    end

  end

end
