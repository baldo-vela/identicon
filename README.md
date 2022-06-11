# Identicon

Project 2: of UDemy's Elixer & Phoenix Bootcamp Taught by Stephen Grider

Identicon is a simple project written in Elixir that demonstrates Elixir's capacity to manipulate images. In essence it will generate an identicon image based on a string of characters.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `identicon` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:identicon, "~> 0.1.0"}
  ]
end
```
Note: :egd isn’t the part of Erlang-OTP release anymore, so when adding {:egd, github: "erlang/egd"} to your dependencies, you’d need to install rebar, the erlang build tool, as this library depends on rebar. Run `mix local.rebar --force` to install rebar (and rebar3). After installing rebar close and re-open your terminal and run `mix deps.get` inside the project folder.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/identicon>.

