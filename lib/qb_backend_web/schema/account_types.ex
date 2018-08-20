defmodule QbBackendWeb.Schema.AccountTypes do
  @moduledoc """
  This module contains GraphQL types used with
  the accounts context.
  """
  use Absinthe.Schema.Notation

  alias QbBackendWeb.Resolvers.Accounts

  @desc "queries for the account types"
  object :account_queries do
    @desc "The list of available users"
    field :users, list_of(:user) do
      resolve(&Accounts.get_people/3)
    end
  end

  @desc "mutations for the account types"
  object :account_mutations do
    @desc "user login mutation"
    field :login, :session do
      arg(:input, non_null(:session_input))
      resolve(&Accounts.login/3)
    end

    @desc "user sign up mutation"
    field :sign_up, :user do
      arg(:input, non_null(:sign_up_input))
      resolve(&Accounts.sign_up/3)
    end
  end

  @desc "an input object"
  input_object :session_input do
    field(:username, non_null(:string))
    field(:hash, non_null(:string))
  end

  @desc "A session object on the system"
  object :session do
    field(:profile, :profile)
    field(:token, :string)
  end

  @desc "Contains a user object in the system "
  object :user do
    field(:id, :id)
    field(:name, :string)
  end

  @desc "Contains a profile object of user on the system"
  object :profile do
    field(:id, :id)
    field(:username, :string)
    field(:role, :string)
    field(:bio, :string)
    field(:avatar_link, :string)
  end

  @desc "contains input object for a user"
  input_object :sign_up_input do
    field(:name, non_null(:string))
    field(:hash, non_null(:string))
  end
end
