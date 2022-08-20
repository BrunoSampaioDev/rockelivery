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

  describe "show/1" do
    test "when not there is a user the given id, returns the error", %{conn: conn} do
      id = "61d04873-9dd0-416e-a0a3-9b67af8b81c4"
      insert(:user)

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:not_found)

      assert %{"errors" => "User not found"} = response
    end

    test "when there is a user the given id, show the user", %{conn: conn} do
      id = "84915c02-6537-4859-b609-87b2b9bf67a3"
      insert(:user)

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "id" => "84915c02-6537-4859-b609-87b2b9bf67a3"
               }
             } = response
    end
  end

  describe "update/2" do
    test "when not there is valid id format, returns the error", %{conn: conn} do
      id = "1102912c-d527-4d7c-8ff0-invalid-uuid"

      updated_params = %{
        "address" => "updated address",
        "email" => "updated@mail.com"
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, updated_params))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid UUID"} = response
    end

    test "when not there is a user the given id, returns the error", %{conn: conn} do
      id = "1102912c-d527-4d7c-8ff0-aae59e8e34b4"

      updated_params = %{
        "address" => "updated address",
        "email" => "updated@mail.com"
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, updated_params))
        |> json_response(:not_found)

      assert %{"errors" => "User not found"} = response
    end

    test "when not there is a password, returns the error", %{conn: conn} do
      insert(:user, %{id: "1102912c-d527-4d7c-8ff0-aae59e8e34b4"})

      id = "1102912c-d527-4d7c-8ff0-aae59e8e34b4"

      updated_params = %{
        "address" => "updated address",
        "email" => "updated@mail.com"
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, updated_params))
        |> json_response(:bad_request)

      assert %{"errors" => %{"password" => ["can't be blank"]}} = response
    end

    test "when all params are valid, update the user", %{conn: conn} do
      insert(:user, %{id: "1102912c-d527-4d7c-8ff0-aae59e8e34b4"})

      id = "1102912c-d527-4d7c-8ff0-aae59e8e34b4"

      updated_params = %{
        "address" => "updated address",
        "email" => "updated@mail.com",
        "password" => "123123"
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, updated_params))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "address" => "updated address",
                 "email" => "updated@mail.com",
                 "id" => "1102912c-d527-4d7c-8ff0-aae59e8e34b4"
               }
             } = response
    end
  end

  describe "delete/1" do
    test "when not there is a user the given id, returns the error", %{conn: conn} do
      id = "61d04873-9dd0-416e-a0a3-9b67af8b81c4"
      insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:not_found)

      assert response == %{"errors" => "User not found"}
    end

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
