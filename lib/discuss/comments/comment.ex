defmodule Discuss.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :content, :string
    belongs_to :user, Discuss.Users.User
    belongs_to :topic, Discuss.Topics.Topic

    timestamps()
  end

  @doc false
  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
