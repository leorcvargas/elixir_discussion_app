defmodule DiscussWeb.Channels.Comments do
  use DiscussWeb, :channel

  alias Discuss.{Topics, Comments}

  def join("comments:" <> topic_id, _auth_params, socket) do
    parsed_topic_id = String.to_integer(topic_id)
    topic = Topics.get_by_id_and_load_full_comments(parsed_topic_id)

    response = DiscussWeb.TopicView.render("topic.json", topic: topic)

    {:ok, response, assign(socket, :topic, topic)}
  end

  def handle_in("comment:add", %{"content" => content}, socket) do
    topic = socket.assigns.topic
    user_id = socket.assigns.user_id

    case Comments.create(topic, user_id, %{content: content}) do
      {:ok, comment} ->
        response = %{comment: DiscussWeb.CommentView.render("show.json", comment: comment)}
        broadcast!(socket, "comments:#{topic.id}:new", response)
        {:reply, :ok, socket}

      {:error, reason} ->
        {:reply, {:error, reason}, socket}
    end
  end
end
