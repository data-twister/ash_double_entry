# SPDX-FileCopyrightText: 2023 ash_double_entry contributors <https://github.com/ash-project/ash_double_entry/graphs/contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshDoubleEntry.Description do
  @moduledoc """
  An extension for creating double-entry ledger description entries. See the getting started guide for more.
  """

  @description %Spark.Dsl.Section{
    name: :description,
    schema: [
      transfer_resource: [
        type: {:spark, Ash.Resource},
        doc: "The resource used for transfers",
        required: true
      ],
      account_resource: [
        type: {:spark, Ash.Resource},
        doc: "The resource used for accounts",
        required: true
      ]
    ]
  }

  @sections [@description]

  @transformers [
    AshDoubleEntry.Description.Transformers.AddStructure
  ]

  use Spark.Dsl.Extension,
    sections: @sections,
    transformers: @transformers
end
