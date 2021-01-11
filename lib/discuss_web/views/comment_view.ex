defmodule DiscussWeb.CommentView do
  use DiscussWeb, :view

  def render("comment.json", %{comment: comment}) do
    %{
      id: comment.id,
      content: comment.content,
      topic_id: comment.topic_id,
      user_id: comment.user_id,
      user:
        case comment.user do
          %Ecto.Association.NotLoaded{} -> nil
          _ -> DiscussWeb.UserView.render("show.json", user: comment.user)
        end
    }
  end

  def render("show.json", %{comment: comment}) do
    render_one(comment, DiscussWeb.CommentView, "comment.json")
  end

  def render("index.json", %{comments: comments}) do
    render_many(comments, DiscussWeb.CommentView, "comment.json")
  end
end
