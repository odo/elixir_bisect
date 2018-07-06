defmodule Bisect.Source do

  @callback init(init_args::any()) :: state::any()

  @callback first_index(state::any()) :: first_index::any()
  @callback last_index(state::any()) :: list_index::any()

  @callback next_index(index::any(), state::any()) :: next_index::any()
  @callback previous_index(index::any(), state::any()) :: previous_index::any()

  @callback value(index::any(), state::any()) :: value::any()

end
