# SPDX-FileCopyrightText: 2023 ash_double_entry contributors <https://github.com/ash-project/ash_double_entry/graphs/contributors>
#
# SPDX-License-Identifier: MIT

defmodule AshDoubleEntry.Description.Info do
  @moduledoc "Introspection helpers for `AshDoubleEntry.Description`"
  use Spark.InfoGenerator, extension: AshDoubleEntry.Description, sections: [:description]
end
