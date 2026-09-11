# SPDX-FileCopyrightText: 2023 ash_double_entry contributors <https://github.com/ash-project/ash_double_entry/graphs/contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshDoubleEntry.Test.Account do
  @moduledoc false
  use Ash.Resource,
    domain: AshDoubleEntry.Test.Domain,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshDoubleEntry.Account]

  postgres do
    table "accounts"
    repo(AshDoubleEntry.Test.Repo)
  end

  account do
    pre_check_identities_with AshDoubleEntry.Test.Domain
    transfer_resource AshDoubleEntry.Test.Transfer
    balance_resource AshDoubleEntry.Test.Balance
    description_resource(AshDoubleEntry.Test.Description)
    open_action_accept [:allow_zero_balance]
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :identifier, :string do
      allow_nil? false
    end

    attribute :currency, :string do
      allow_nil? false
    end

    attribute :allow_zero_balance, :boolean do
      default true
    end
  end
end
