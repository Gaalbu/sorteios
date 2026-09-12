defmodule SorteiosWeb.SessionControllerTest do
  use SorteiosWeb.ConnCase

  test "logout preserves the selected locale", %{conn: conn} do
    conn =
      conn
      |> init_test_session(%{"locale" => "pt_BR", "name" => "User"})
      |> delete(Routes.session_path(conn, :delete))

    assert redirected_to(conn) == "/"
    assert get_session(conn, "locale") == "pt_BR"
    refute get_session(conn, "name")
  end
end
