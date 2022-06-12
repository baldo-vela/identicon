defmodule Identicon do


  @moduledoc """
    Udemy course on Elixir and Phoenix
    Draws an identicon and saves it to a PNG

  """

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)

  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}

  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end

    %Identicon.Image{image | grid: grid}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      # TODO: Change this to non deprecaated Enum.chunk_every()
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    # [99, 73, 209]
    [first, second | _tail ] = row
    # [99, 73, 209, 73, 99]
    row ++ [second, first]
  end

  @doc """
    Given a structured input of hex values, aasigns the first three hex values as a color to a structured output

    ## Examples
      iex> hex = Identicon.hash_input("asdf")
      %Identicon.Image{
        color: nil,
        grid: nil,
        hex: [145, 46, 200, 3, 178, 206, 73, 228, 165, 65, 6, 141, 73, 90, 181, 112],
        pixel_map: nil
      }
      iex> Identicon.pick_color(hex)
      %Identicon.Image{
        color: {145, 46, 200},
        grid: nil,
        hex: [145, 46, 200, 3, 178, 206, 73, 228, 165, 65, 6, 141, 73, 90, 181, 112],
        pixel_map: nil
      }
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
    Takes a given string, converts it using MD5 hashing, and dumps the output into a struct

    ## Examples
      iex> Identicon.hash_input("asdf")
      %Identicon.Image{
        color: nil,
        grid: nil,
        hex: [145, 46, 200, 3, 178, 206, 73, 228, 165, 65, 6, 141, 73, 90, 181, 112],
        pixel_map: nil
      }
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

end
