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
      |> image_extension()
      |> unique_filename()


    case do_upload(asset_bucket, filename, binary_data) do
      {:ok, _} ->
        {:ok, "https://#{asset_bucket}.s3.amazonaws.com/#{asset_bucket}/#{filename}"}
       {:error, _} = resp -> {:error, resp}
    end
  end
   defp unique_filename(extension) do
    UUID.uuid4(:hex) <> extension
  end
   defp do_upload(bucket, file, data) do
    S3.put_object(bucket, file, data)
    |> ExAws.request()
  end
   # pattern match binary to file type
  defp image_extension(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>), do: ".png"
  defp image_extension(<<0xff, 0xD8, _::binary>>), do: ".jpg"
end
