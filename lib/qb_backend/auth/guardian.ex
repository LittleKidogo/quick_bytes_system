defmodule QbBackend.Auth.Guardian do
  @moduledoc """
  Authentication Serializer and Parser for Guardian
  """
  use Guardian, otp_app: :qb_backend

  # get accounts context to get or create user
  alias QbBackend.{Accounts, Accounts.Profile}

  # get a field that can Identify a user
  def subject_for_token(%Profile{} = prof, _claims) do
    {:ok, "Profile:#{prof.id}"}
  end

  # we can't Identify that resource
  def subject_for_token(_, _) do
    {:error, :unknown_resource_type}
  end

  # determine which subject we are Identifying
  def resource_from_claims(%{"sub" => sub}), do: resource_from_subject(sub)
  def resource_from_claims(_), do: {:error, :missing_subject}

  # pic a resource from the provided subject
  defp resource_from_subject("Profile:" <> id), do: Accounts.get_profile(id)
  defp resource_from_subject(_), do: {:error, :unknown_resource_type}
end
