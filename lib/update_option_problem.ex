defmodule UpdateOptionProblem do
  @moduledoc """
  Documentation for `UpdateOptionProblem`.
  """

  alias ExAws.S3

  @doc """
  This function is ok because it does not specify the optional content_type
  """
  def this_is_ok do
    "path/to/big/file"
    |> S3.Upload.stream_file()
    |> S3.upload("my-bucket", "path/on/s3")
    |> ExAws.request()
  end

  @doc """
  This function would work correctly, but fails the dialyzer.

  The problem is the because the optional content_type is valid according to the
  documentation, but not according to the @spec for the S3.upload/4 function
  """
  def this_is_a_problem do
    "path/to/big/file"
    |> S3.Upload.stream_file()
    |> S3.upload("my-bucket", "path/on/s3", content_type: "image/jpeg")
    |> ExAws.request()
  end
end
