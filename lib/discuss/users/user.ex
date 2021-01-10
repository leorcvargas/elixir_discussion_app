defmodule Discuss.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :provider, :string
    field :token, :string
    has_many :topics, Discuss.Topics.Topic
    has_many :comments, Discuss.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [:email, :name, :provider, :token])
    |> validate_required([:email, :name, :provider, :token])
  end
end
