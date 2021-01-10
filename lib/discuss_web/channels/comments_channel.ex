defmodule DiscussWeb.Channels.Comments do
  use DiscussWeb, :channel

  alias Discuss.{Topics, Comments}

  def join("comments:" <> topic_id, _auth_params, socket) do
    parsed_topic_id = String.to_integer(topic_id)
    topic = Topics.get_by_id(parsed_topic_id)

    {:ok, %{}, assign(socket, :topic, topic)}
  end

  def handle_in("comment:add", %{"content" => content}, socket) do
    topic = socket.assigns.topic

    {result, changeset} = Comments.create(topic, %{content: content})

    case result do
      {:ok, _comment} ->
        {:reply, :ok, socket}

      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end

    {:reply, :ok, socket}
  end
end
