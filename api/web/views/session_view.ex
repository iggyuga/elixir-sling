defmodule Sling.SessionView do
  use Sling.Web, :view
  
  # when a user signs up or logs in
  # we’ll want to respond with the user data as well as the jwt

  def render("show.json", %{user: user, jwt: jwt}) do
    %{
      data: render_one(user, Sling.UserView, "user.json"),
      meta: %{token: jwt}
    }
  end

  def render("error.json", _) do
    %{error: "Invalid email or password"}
  end

  def render("delete.json", _) do
    %{ok: true}
  end

  def render("forbidden.json", %{error: error}) do
    %{error: error}
  end
end