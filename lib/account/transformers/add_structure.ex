# SPDX-FileCopyrightText: 2023 ash_double_entry contributors <https://github.com/ash-project/ash_double_entry/graphs/contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshDoubleEntry.Account.Transformers.AddStructure do
  @moduledoc false
  use Spark.Dsl.Transformer
  import Spark.Dsl.Builder

  def transform(dsl) do
    open_action_accept =
      Spark.Dsl.Transformer.get_option(dsl, [:account], :open_action_accept) || []

    _transfer_resource = Spark.Dsl.Transformer.get_option(dsl, [:account], :transfer_resource)
    balance_resource = Spark.Dsl.Transformer.get_option(dsl, [:account], :balance_resource)

    description_resource =
      Spark.Dsl.Transformer.get_option(dsl, [:account], :description_resource)

    dsl =
      if description_resource do
        Ash.Resource.Builder.add_new_relationship(
          dsl,
          :has_many,
          :descriptions,
          description_resource,
          source_attribute: :id,
          destination_attribute: :account_id,
          no_attributes?: true
        )
      else
        dsl
      end

    dsl
    |> Ash.Resource.Builder.add_new_action(:create, :open,
      accept: [:identifier, :currency] ++ open_action_accept
    )
    |> Ash.Resource.Builder.add_new_action(:read, :lock_accounts,
      preparations: [{AshDoubleEntry.Account.Preparations.LockForUpdate, []}]
    )
    |> Ash.Resource.Builder.add_new_relationship(
      :has_many,
      :balances,
      balance_resource,
      source_attribute: :id,
      destination_attribute: :account_id,
      no_attributes?: true
    )
  end
end
