defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true
  import Rockelivery.Factory

  describe "create/1" do
    test "when all params are valid, create the user", %{conn: conn} do
      params = build(:user_params, %{"email" => "any_mail@email.com"})

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "user created",
               "user" => %{
                 "age" => 31,
                 "cpf" => "13718203766",
                 "email" => "any_mail@email.com"
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = build(:user_params, %{"age" => 14, "cpf" => "123", "cep" => "321"})

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "errors" => %{
                 "age" => ["must be greater than or equal to 18"],
                 "cep" => ["should be 8 character(s)"],
                 "cpf" => ["should be 11 character(s)"]
               }
             } = response
    end
  end

  describe "delete/2" do
    test "when there is a user the given id, deletes the user", %{conn: conn} do
      id = "84915c02-6537-4859-b609-87b2b9bf67a3"
      insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end
end
