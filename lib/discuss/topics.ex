defmodule Discuss.Topics do
  import Ecto
  import Ecto.Query, warn: false
  alias Discuss.Repo

  alias Discuss.Topics.Topic

  def show_all_topics() do
    Repo.all(Topic)
  end

  def create_topic(user, attrs \\ %{}) do
    user
    |> build_assoc(:topics)
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get!(Topic, id)
  end

  def get_by_id_and_load_full_comments(id) do
    get_by_id(id)
    |> Repo.preload([:user, comments: [:user]])
  end

  def get_topic_and_changeset_by_id(id) do
    topic = get_by_id(id)
    changeset = Topic.changeset(topic)

    {topic, changeset}
  end

  def update(id, attrs \\ %{}) do
    old_topic = get_by_id(id)

    result =
      Topic.changeset(old_topic, attrs)
      |> Repo.update()

    {result, old_topic}
  end

  def does_user_own_topic?(user_id, topic_id) do
    Repo.get(Topic, topic_id).user_id === user_id
  end

  def delete(id) do
    Repo.get!(Topic, id)
    |> Repo.delete!()
  end
end
