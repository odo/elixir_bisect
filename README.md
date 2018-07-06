# Bisect

Binary search implementation with callback modules.

Rules for `Bisect.find(value, backend, state_args)` API
- returns `{index, value}`
- if value is not found exactly, return one to the right
- if value occurs repeatedly, returns the rightmost

To use your own datasource, please implement [Bisect.Source](lib/bisect_source.ex).

Example using [Bisect.List](lib/bisect_list.ex):

```elixir
iex(1)> list = [0, 2, 3, 3]
[0, 2, 3, 3]
iex(2)> Bisect.find(0, Bisect.List, list)
{0, 0}
iex(3)> Bisect.find(1, Bisect.List, list)
{1, 2}
iex(4)> Bisect.find(3, Bisect.List, list)
{3, 3}
iex(5)> Bisect.find(4, Bisect.List, list)
{3, 3}
```
