defmodule SorteiosWeb.LayoutView do
  use SorteiosWeb, :view

  def locale_path(conn, locale) do
    query = conn.query_params |> Map.put("locale", locale) |> URI.encode_query()
    "#{conn.request_path}?#{query}"
  end

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}
end
