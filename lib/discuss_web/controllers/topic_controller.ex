defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Topics
  alias Discuss.Topics.Topic

  plug DiscussWeb.Plugs.RequireAuth
       when action in [
              :new,
              :create,
              :edit,
              :update,
              :delete
            ]

  plug :check_topic_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    topics = Topics.show_all_topics()

    render(conn, "index.html", topics: topics)
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Topics.get_by_id(topic_id)

    render(conn, "show.html", topic: topic)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    case Topics.create_topic(conn.assigns.user, topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    {topic, changeset} = Topics.get_topic_and_changeset_by_id(topic_id)

    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    {result, old_topic} = Topics.update(topic_id, topic)

    case result do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Topics.delete(topic_id)

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  defp check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    case Topics.does_user_own_topic?(conn.assigns.user.id, topic_id) do
      true ->
        conn

      false ->
        conn
        |> put_flash(:error, "You can't do that")
        |> redirect(to: Routes.topic_path(conn, :index))
        |> halt()
    end
  end
end
