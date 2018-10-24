defmodule QbBackend.MediaAssetsManager do
  @moduledoc """
  This is a boundary module used to deal with handling media assets for the Quick-bytes Application.
  Use this module to handle any media assets used in the application such as images and videos.
  """
  alias ExAws.S3

  def upload_asset(asset_binary) do
    asset_bucket = "qb-media-bucket"
    {:ok, binary_data} = Base.decode64(asset_binary)

    filename =
      binary_data
      |> file_extension()
      |> unique_filename()

    case do_upload(asset_bucket, filename, binary_data) do
      {:ok, _} ->
        link =  make_link(asset_bucket, filename)
        {:ok, link}

      {:error, _} = resp ->
        {:error, resp}
    end
  end

  defp unique_filename(extension) do
    UUID.uuid4(:hex) <> extension
  end

  defp do_upload(bucket, file, data) do
    S3.put_object(bucket, file, data)
    |> ExAws.request()
  end

  defp make_link(bucket_name, file_name) do
    "https://#{bucket_name}.s3.amazonaws.com/#{bucket_name}/#{file_name}"
  end

  # pattern match binary to file type

  @spec file_extension(any()) :: String.t()
  def file_extension(bin_data) do
    case bin_data do
      <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>> ->
        ".png"

      <<0xFF, 0xD8, _::binary>> ->
        ".jpg"

      <<0x1A, 0x45, 0xDF, 0xA3, _::binary>> ->
        ".webm"

      <<0x50, 0x4B, 0x03, 0x04, 0x14, 0x00, 0x06, 0x00, _::binary>> ->
        ".pptx"

      <<0x47, 0x49, 0x46, 0x38, _::binary>> ->
        ".gif"

      _any_other ->
        :ignore
    end
  end
end
