defmodule DiscussWeb.TopicView do
  use DiscussWeb, :view

  def render("topic.json", %{topic: topic}) do
    %{
      id: topic.id,
      title: topic.title,
      user_id: topic.user_id,
      user: DiscussWeb.UserView.render("show.json", user: topic.user),
      comments: DiscussWeb.CommentView.render("index.json", comments: topic.comments)
    }
  end
end
