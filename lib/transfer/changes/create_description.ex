defmodule AshPhoenixStarter.Transfers.Changes.CreateDescription do
  @moduledoc false
  use Ash.Resource.Change

  def change(changeset, _opts, _context) do
    case Ash.Changeset.get_argument(changeset, :description) do
      nil ->
        changeset

      description ->
        account_id =
          Ash.Changeset.get_attribute(changeset, :from_account_id) ||
            Ash.Changeset.get_argument(changeset, :from_account_id)

        Ash.Changeset.manage_relationship(
          changeset,
          :description_record,
          %{
            description: description,
            account_id: account_id
          },
          type: :create
        )
    end
  end
end
