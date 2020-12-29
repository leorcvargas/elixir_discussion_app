defmodule Discuss.Topics do
  import Ecto.Query, warn: false
  alias Discuss.Repo

  alias Discuss.Topics.Topic

  def show_all_topics() do
    Repo.all(Topic)
  end

  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end
end
