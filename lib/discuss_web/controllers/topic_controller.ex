defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias Discuss.Topics
  alias Discuss.Topics.Topic

  def index(conn, _params) do
    topics = Topics.show_all_topics()

    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    case Topics.create_topic(topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
