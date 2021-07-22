# UpdateOptionProblem

This is a repo to demonstrate a problem introduced in ex-aws/ex_aws_s3 v2.2.0

## The problem

The problem is with the spec of the S3.upload/4 function.

The documentation states:

  These options are specific to this function
  * See `Task.async_stream/5`'s `:max_concurrency` and `:timeout` options.
    * `:max_concurrency` - only applies when uploading a stream. Sets the maximum number of tasks to run at the same time. Defaults to `4`
    * `:timeout` - the maximum amount of time (in milliseconds) each task is allowed to execute for. Defaults to `30_000`.

    All other options (ex. `:content_type`) are passed through to
  `ExAws.S3.initiate_multipart_upload/3`.

But the problem is that the spec for the upload function is 
  @spec upload(
          source :: Enumerable.t(),
          bucket :: String.t(),
          path :: String.t(),
          opts :: upload_opts
        ) :: __MODULE__.Upload.t()

  with 

  @type upload_opt :: {:max_concurrency, pos_integer} | initiate_multipart_upload_opt
  @type upload_opts :: [upload_opt]

  so the additional options are not part of the function spec and cause the dialyzer to fail.
