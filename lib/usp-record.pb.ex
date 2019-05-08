defmodule UspRecord.Record do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          record_type: {atom, any},
          version: String.t(),
          to_id: String.t(),
          from_id: String.t(),
          payload_security: atom | integer,
          mac_signature: binary,
          sender_cert: binary
        }
  defstruct [
    :record_type,
    :version,
    :to_id,
    :from_id,
    :payload_security,
    :mac_signature,
    :sender_cert
  ]

  oneof :record_type, 0
  field :version, 1, type: :string
  field :to_id, 2, type: :string
  field :from_id, 3, type: :string
  field :payload_security, 4, type: UspRecord.Record.PayloadSecurity, enum: true
  field :mac_signature, 5, type: :bytes
  field :sender_cert, 6, type: :bytes
  field :no_session_context, 7, type: UspRecord.NoSessionContextRecord, oneof: 0
  field :session_context, 8, type: UspRecord.SessionContextRecord, oneof: 0
end

defmodule UspRecord.Record.PayloadSecurity do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :PLAINTEXT, 0
  field :TLS12, 1
end

defmodule UspRecord.NoSessionContextRecord do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          payload: binary
        }
  defstruct [:payload]

  field :payload, 2, type: :bytes
end

defmodule UspRecord.SessionContextRecord do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          session_id: non_neg_integer,
          sequence_id: non_neg_integer,
          expected_id: non_neg_integer,
          retransmit_id: non_neg_integer,
          payload_sar_state: atom | integer,
          payloadrec_sar_state: atom | integer,
          payload: [binary]
        }
  defstruct [
    :session_id,
    :sequence_id,
    :expected_id,
    :retransmit_id,
    :payload_sar_state,
    :payloadrec_sar_state,
    :payload
  ]

  field :session_id, 1, type: :uint64
  field :sequence_id, 2, type: :uint64
  field :expected_id, 3, type: :uint64
  field :retransmit_id, 4, type: :uint64
  field :payload_sar_state, 5, type: UspRecord.SessionContextRecord.PayloadSARState, enum: true
  field :payloadrec_sar_state, 6, type: UspRecord.SessionContextRecord.PayloadSARState, enum: true
  field :payload, 7, repeated: true, type: :bytes
end

defmodule UspRecord.SessionContextRecord.PayloadSARState do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :NONE, 0
  field :BEGIN, 1
  field :INPROCESS, 2
  field :COMPLETE, 3
end
