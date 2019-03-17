defmodule LrmiWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :lrmi


  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_lrmi_key",
    signing_salt: "T3cTH6S2"

  plug Absinthe.Plug,
    schema: LrmiGraphql.Schema,
    json_codec: Jason
end
