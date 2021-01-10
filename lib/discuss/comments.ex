defmodule Discuss.Comments do
  import Ecto
  import Ecto.Query, warn: false

  alias Discuss.Comments.Comment
  alias Discuss.Repo

  def create(topic, attrs \\ %{}) do
    changeset =
      topic
      |> build_assoc(:comments)
      |> Comment.changeset(attrs)

    result = Repo.insert(changeset)

    {result, changeset}
  end
end
