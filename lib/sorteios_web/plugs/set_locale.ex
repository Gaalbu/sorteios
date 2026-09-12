defmodule SorteiosWeb.Plugs.SetLocale do
  @moduledoc """
  Selects the request locale from the query, session, or browser preferences.
  """

  import Plug.Conn

  @locales ["en", "pt_BR"]

  def init(opts), do: opts

  def call(conn, _opts) do
    conn = fetch_query_params(conn)

    locale =
      conn
      |> requested_locale()
      |> normalize()

    Gettext.put_locale(SorteiosWeb.Gettext, locale)

    conn
    |> put_session("locale", locale)
    |> assign(:locale, locale)
  end

  def known_locales, do: @locales

  def normalize(locale) when locale in @locales, do: locale
  def normalize("pt"), do: "pt_BR"
  def normalize("pt-BR"), do: "pt_BR"
  def normalize("en-US"), do: "en"
  def normalize("en-GB"), do: "en"
  def normalize(_locale), do: "en"

  defp requested_locale(conn) do
    conn.params["locale"] ||
      get_session(conn, "locale") ||
      conn |> get_req_header("accept-language") |> List.first() |> browser_locale()
  end

  defp browser_locale(nil), do: "en"

  defp browser_locale(header) do
    header
    |> String.split(",")
    |> List.first()
    |> String.trim()
  end
end
