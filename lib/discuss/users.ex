defmodule Discuss.Users do
  import Ecto.Query, warn: false

  alias Discuss.Repo
  alias Discuss.Users.User

  def sign_up(user_params) do
    changeset = User.changeset(%User{}, user_params)
    insert_or_update(changeset)
  end

  def insert_or_update(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end

  def get_by_id(user_id) do
    Repo.get(User, user_id)
  end
end
