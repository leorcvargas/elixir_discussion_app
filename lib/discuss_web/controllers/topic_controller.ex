defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias Discuss.Topics
  alias Discuss.Topics.Topic

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    case Topics.create_topic(topic) do
      {:ok, _topic} ->
        redirect(conn, to: Routes.page_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
