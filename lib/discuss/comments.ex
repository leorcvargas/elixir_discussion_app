defmodule Discuss.Comments do
  import Ecto
  import Ecto.Query, warn: false

  alias Discuss.Comments.Comment
  alias Discuss.Repo

  def create(topic, user_id, attrs \\ %{}) do
    changeset =
      topic
      |> build_assoc(:comments, user_id: user_id)
      |> Comment.changeset(attrs)

    case Repo.insert(changeset) do
      {:ok, comment} ->
        comment_with_user = comment |> Repo.preload(:user)
        {:ok, comment_with_user}
      {:error, reason} ->
        {:error, reason}
    end
  end
end
