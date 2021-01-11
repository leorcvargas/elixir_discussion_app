defmodule DiscussWeb.UserView do
  use DiscussWeb, :view

  def render("user.json", %{user: user}) do
    %{id: user.id, name: user.name}
  end

  def render("show.json", %{user: user}) do
    render_one(user, DiscussWeb.UserView, "user.json")
  end
end
