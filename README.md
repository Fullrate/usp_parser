# UspParser

The module encodes USP messages into protobuf 3, and decodes them from protobuf 3.

## Usage

```elixir

iex(1)>  msg = Usp.Msg.new(header: Usp.Header.new(msg_id: "1", msg_type: Usp.Header.MsgType.value(:ADD)), body: Usp.Body.new(msg_body: {:request, Usp.Request.new(req_type: {:add, Usp.Add.new(allow_partial: false, create_objs: [Usp.Add.CreateObject.new(obj_path: "Somewhere.", param_settings: [Usp.Add.CreateParamSetting.new(param: "Somewhere.Crazy", value: "val1", required: true)])])})}))                                
%Usp.Msg{
  body: %Usp.Body{
    msg_body: {:request,
     %Usp.Request{
       req_type: {:add,
        %Usp.Add{
          allow_partial: false,
          create_objs: [
            %Usp.Add.CreateObject{
              obj_path: "Somewhere.",
              param_settings: [
                %Usp.Add.CreateParamSetting{
                  param: "Somewhere.Crazy",
                  required: true,
                  value: "val1"
                }
              ]
            }
          ]
        }}
     }}
  },
  header: %Usp.Header{msg_id: "1", msg_type: 8}
}
iex(2)> Usp.Msg.encode(msg)                                                                                                                                   <<10, 5, 10, 1, 49, 16, 8, 18, 45, 10, 43, 42, 41, 18, 39, 10, 10, 83, 111, 109,                                                                                 101, 119, 104, 101, 114, 101, 46, 18, 25, 10, 15, 83, 111, 109, 101, 119, 104,
  101, 114, 101, 46, 67, 114, 97, 122, 121, 18, 4, 118, 97, ...>>

```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `usp_parser` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:usp_parser, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/usp_parser](https://hexdocs.pm/usp_parser).

