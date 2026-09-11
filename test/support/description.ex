# SPDX-FileCopyrightText: 2023 ash_double_entry contributors <https://github.com/ash-project/ash_double_entry/graphs/contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshDoubleEntry.Test.Description do
  @moduledoc false
  use Ash.Resource,
    domain: AshDoubleEntry.Test.Domain,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshDoubleEntry.Description]

  postgres do
    table "descriptions"
    repo(AshDoubleEntry.Test.Repo)
  end

  description do
    transfer_resource AshDoubleEntry.Test.Transfer
    account_resource AshDoubleEntry.Test.Account
  end

  actions do
    defaults [:read, :destroy]
  end
end
