defmodule Usp.Msg do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          header: Usp.Header.t() | nil,
          body: Usp.Body.t() | nil
        }
  defstruct [:header, :body]

  field :header, 1, type: Usp.Header
  field :body, 2, type: Usp.Body
end

defmodule Usp.Header do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          msg_id: String.t(),
          msg_type: atom | integer
        }
  defstruct [:msg_id, :msg_type]

  field :msg_id, 1, type: :string
  field :msg_type, 2, type: Usp.Header.MsgType, enum: true
end

defmodule Usp.Header.MsgType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :ERROR, 0
  field :GET, 1
  field :GET_RESP, 2
  field :NOTIFY, 3
  field :SET, 4
  field :SET_RESP, 5
  field :OPERATE, 6
  field :OPERATE_RESP, 7
  field :ADD, 8
  field :ADD_RESP, 9
  field :DELETE, 10
  field :DELETE_RESP, 11
  field :GET_SUPPORTED_DM, 12
  field :GET_SUPPORTED_DM_RESP, 13
  field :GET_INSTANCES, 14
  field :GET_INSTANCES_RESP, 15
  field :NOTIFY_RESP, 16
  field :GET_SUPPORTED_PROTO, 17
  field :GET_SUPPORTED_PROTO_RESP, 18
end

defmodule Usp.Body do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          msg_body: {atom, any}
        }
  defstruct [:msg_body]

  oneof :msg_body, 0
  field :request, 1, type: Usp.Request, oneof: 0
  field :response, 2, type: Usp.Response, oneof: 0
  field :error, 3, type: Usp.Error, oneof: 0
end

defmodule Usp.Request do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          req_type: {atom, any}
        }
  defstruct [:req_type]

  oneof :req_type, 0
  field :get, 1, type: Usp.Get, oneof: 0
  field :get_supported_dm, 2, type: Usp.GetSupportedDM, oneof: 0
  field :get_instances, 3, type: Usp.GetInstances, oneof: 0
  field :set, 4, type: Usp.Set, oneof: 0
  field :add, 5, type: Usp.Add, oneof: 0
  field :delete, 6, type: Usp.Delete, oneof: 0
  field :operate, 7, type: Usp.Operate, oneof: 0
  field :notify, 8, type: Usp.Notify, oneof: 0
  field :get_supported_protocol, 9, type: Usp.GetSupportedProtocol, oneof: 0
end

defmodule Usp.Response do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          resp_type: {atom, any}
        }
  defstruct [:resp_type]

  oneof :resp_type, 0
  field :get_resp, 1, type: Usp.GetResp, oneof: 0
  field :get_supported_dm_resp, 2, type: Usp.GetSupportedDMResp, oneof: 0
  field :get_instances_resp, 3, type: Usp.GetInstancesResp, oneof: 0
  field :set_resp, 4, type: Usp.SetResp, oneof: 0
  field :add_resp, 5, type: Usp.AddResp, oneof: 0
  field :delete_resp, 6, type: Usp.DeleteResp, oneof: 0
  field :operate_resp, 7, type: Usp.OperateResp, oneof: 0
  field :notify_resp, 8, type: Usp.NotifyResp, oneof: 0
  field :get_supported_protocol_resp, 9, type: Usp.GetSupportedProtocolResp, oneof: 0
end

defmodule Usp.Error do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          err_code: non_neg_integer,
          err_msg: String.t(),
          param_errs: [Usp.Error.ParamError.t()]
        }
  defstruct [:err_code, :err_msg, :param_errs]

  field :err_code, 1, type: :fixed32
  field :err_msg, 2, type: :string
  field :param_errs, 3, repeated: true, type: Usp.Error.ParamError
end

defmodule Usp.Error.ParamError do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          param_path: String.t(),
          err_code: non_neg_integer,
          err_msg: String.t()
        }
  defstruct [:param_path, :err_code, :err_msg]

  field :param_path, 1, type: :string
  field :err_code, 2, type: :fixed32
  field :err_msg, 3, type: :string
end

defmodule Usp.Get do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          param_paths: [String.t()]
        }
  defstruct [:param_paths]

  field :param_paths, 1, repeated: true, type: :string
end

defmodule Usp.GetResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          req_path_results: [Usp.GetResp.RequestedPathResult.t()]
        }
  defstruct [:req_path_results]

  field :req_path_results, 1, repeated: true, type: Usp.GetResp.RequestedPathResult
end

defmodule Usp.GetResp.RequestedPathResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          requested_path: String.t(),
          err_code: non_neg_integer,
          err_msg: String.t(),
          resolved_path_results: [Usp.GetResp.ResolvedPathResult.t()]
        }
  defstruct [:requested_path, :err_code, :err_msg, :resolved_path_results]

  field :requested_path, 1, type: :string
  field :err_code, 2, type: :fixed32
  field :err_msg, 3, type: :string
  field :resolved_path_results, 4, repeated: true, type: Usp.GetResp.ResolvedPathResult
end

defmodule Usp.GetResp.ResolvedPathResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          resolved_path: String.t(),
          result_params: %{String.t() => String.t()}
        }
  defstruct [:resolved_path, :result_params]

  field :resolved_path, 1, type: :string

  field :result_params, 2,
    repeated: true,
    type: Usp.GetResp.ResolvedPathResult.ResultParamsEntry,
    map: true
end

defmodule Usp.GetResp.ResolvedPathResult.ResultParamsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Usp.GetSupportedDM do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          obj_paths: [String.t()],
          first_level_only: boolean,
          return_commands: boolean,
          return_events: boolean,
          return_params: boolean
        }
  defstruct [:obj_paths, :first_level_only, :return_commands, :return_events, :return_params]

  field :obj_paths, 1, repeated: true, type: :string
  field :first_level_only, 2, type: :bool
  field :return_commands, 3, type: :bool
  field :return_events, 4, type: :bool
  field :return_params, 5, type: :bool
end

defmodule Usp.GetSupportedDMResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          req_obj_results: [Usp.GetSupportedDMResp.RequestedObjectResult.t()]
        }
  defstruct [:req_obj_results]

  field :req_obj_results, 1, repeated: true, type: Usp.GetSupportedDMResp.RequestedObjectResult
end

defmodule Usp.GetSupportedDMResp.RequestedObjectResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          req_obj_path: String.t(),
          err_code: non_neg_integer,
          err_msg: String.t(),
          data_model_inst_uri: String.t(),
          supported_objs: [Usp.GetSupportedDMResp.SupportedObjectResult.t()]
        }
  defstruct [:req_obj_path, :err_code, :err_msg, :data_model_inst_uri, :supported_objs]

  field :req_obj_path, 1, type: :string
  field :err_code, 2, type: :fixed32
  field :err_msg, 3, type: :string
  field :data_model_inst_uri, 4, type: :string
  field :supported_objs, 5, repeated: true, type: Usp.GetSupportedDMResp.SupportedObjectResult
end

defmodule Usp.GetSupportedDMResp.SupportedObjectResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          supported_obj_path: String.t(),
          access: atom | integer,
          is_multi_instance: boolean,
          supported_commands: [Usp.GetSupportedDMResp.SupportedCommandResult.t()],
          supported_events: [Usp.GetSupportedDMResp.SupportedEventResult.t()],
          supported_params: [Usp.GetSupportedDMResp.SupportedParamResult.t()]
        }
  defstruct [
    :supported_obj_path,
    :access,
    :is_multi_instance,
    :supported_commands,
    :supported_events,
    :supported_params
  ]

  field :supported_obj_path, 1, type: :string
  field :access, 2, type: Usp.GetSupportedDMResp.ObjAccessType, enum: true
  field :is_multi_instance, 3, type: :bool

  field :supported_commands, 4,
    repeated: true,
    type: Usp.GetSupportedDMResp.SupportedCommandResult

  field :supported_events, 5, repeated: true, type: Usp.GetSupportedDMResp.SupportedEventResult
  field :supported_params, 6, repeated: true, type: Usp.GetSupportedDMResp.SupportedParamResult
end

defmodule Usp.GetSupportedDMResp.SupportedParamResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          param_name: String.t(),
          access: atom | integer
        }
  defstruct [:param_name, :access]

  field :param_name, 1, type: :string
  field :access, 2, type: Usp.GetSupportedDMResp.ParamAccessType, enum: true
end

defmodule Usp.GetSupportedDMResp.SupportedCommandResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          command_name: String.t(),
          input_arg_names: [String.t()],
          output_arg_names: [String.t()]
        }
  defstruct [:command_name, :input_arg_names, :output_arg_names]

  field :command_name, 1, type: :string
  field :input_arg_names, 2, repeated: true, type: :string
  field :output_arg_names, 3, repeated: true, type: :string
end

defmodule Usp.GetSupportedDMResp.SupportedEventResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          event_name: String.t(),
          arg_names: [String.t()]
        }
  defstruct [:event_name, :arg_names]

  field :event_name, 1, type: :string
  field :arg_names, 2, repeated: true, type: :string
end

defmodule Usp.GetSupportedDMResp.ParamAccessType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :PARAM_READ_ONLY, 0
  field :PARAM_READ_WRITE, 1
  field :PARAM_WRITE_ONLY, 2
end

defmodule Usp.GetSupportedDMResp.ObjAccessType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :OBJ_READ_ONLY, 0
  field :OBJ_ADD_DELETE, 1
  field :OBJ_ADD_ONLY, 2
  field :OBJ_DELETE_ONLY, 3
end

defmodule Usp.GetInstances do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          obj_paths: [String.t()],
          first_level_only: boolean
        }
  defstruct [:obj_paths, :first_level_only]

  field :obj_paths, 1, repeated: true, type: :string
  field :first_level_only, 2, type: :bool
end

defmodule Usp.GetInstancesResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          req_path_results: [Usp.GetInstancesResp.RequestedPathResult.t()]
        }
  defstruct [:req_path_results]

  field :req_path_results, 1, repeated: true, type: Usp.GetInstancesResp.RequestedPathResult
end

defmodule Usp.GetInstancesResp.RequestedPathResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          requested_path: String.t(),
          err_code: non_neg_integer,
          err_msg: String.t(),
          curr_insts: [Usp.GetInstancesResp.CurrInstance.t()]
        }
  defstruct [:requested_path, :err_code, :err_msg, :curr_insts]

  field :requested_path, 1, type: :string
  field :err_code, 2, type: :fixed32
  field :err_msg, 3, type: :string
  field :curr_insts, 4, repeated: true, type: Usp.GetInstancesResp.CurrInstance
end

defmodule Usp.GetInstancesResp.CurrInstance do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          instantiated_obj_path: String.t(),
          unique_keys: %{String.t() => String.t()}
        }
  defstruct [:instantiated_obj_path, :unique_keys]

  field :instantiated_obj_path, 1, type: :string

  field :unique_keys, 2,
    repeated: true,
    type: Usp.GetInstancesResp.CurrInstance.UniqueKeysEntry,
    map: true
end

defmodule Usp.GetInstancesResp.CurrInstance.UniqueKeysEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Usp.GetSupportedProtocol do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          controller_supported_protocol_versions: String.t()
        }
  defstruct [:controller_supported_protocol_versions]

  field :controller_supported_protocol_versions, 1, type: :string
end

defmodule Usp.GetSupportedProtocolResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          agent_supported_protocol_versions: String.t()
        }
  defstruct [:agent_supported_protocol_versions]

  field :agent_supported_protocol_versions, 1, type: :string
end

defmodule Usp.Add do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          allow_partial: boolean,
          create_objs: [Usp.Add.CreateObject.t()]
        }
  defstruct [:allow_partial, :create_objs]

  field :allow_partial, 1, type: :bool
  field :create_objs, 2, repeated: true, type: Usp.Add.CreateObject
end

defmodule Usp.Add.CreateObject do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          obj_path: String.t(),
          param_settings: [Usp.Add.CreateParamSetting.t()]
        }
  defstruct [:obj_path, :param_settings]

  field :obj_path, 1, type: :string
  field :param_settings, 2, repeated: true, type: Usp.Add.CreateParamSetting
end

defmodule Usp.Add.CreateParamSetting do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          param: String.t(),
          value: String.t(),
          required: boolean
        }
  defstruct [:param, :value, :required]

  field :param, 1, type: :string
  field :value, 2, type: :string
  field :required, 3, type: :bool
end

defmodule Usp.AddResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          created_obj_results: [Usp.AddResp.CreatedObjectResult.t()]
        }
  defstruct [:created_obj_results]

  field :created_obj_results, 1, repeated: true, type: Usp.AddResp.CreatedObjectResult
end

defmodule Usp.AddResp.CreatedObjectResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          requested_path: String.t(),
          oper_status: Usp.AddResp.CreatedObjectResult.OperationStatus.t() | nil
        }
  defstruct [:requested_path, :oper_status]

  field :requested_path, 1, type: :string
  field :oper_status, 2, type: Usp.AddResp.CreatedObjectResult.OperationStatus
end

defmodule Usp.AddResp.CreatedObjectResult.OperationStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          oper_status: {atom, any}
        }
  defstruct [:oper_status]

  oneof :oper_status, 0

  field :oper_failure, 1,
    type: Usp.AddResp.CreatedObjectResult.OperationStatus.OperationFailure,
    oneof: 0

  field :oper_success, 2,
    type: Usp.AddResp.CreatedObjectResult.OperationStatus.OperationSuccess,
    oneof: 0
end

defmodule Usp.AddResp.CreatedObjectResult.OperationStatus.OperationFailure do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          err_code: non_neg_integer,
          err_msg: String.t()
        }
  defstruct [:err_code, :err_msg]

  field :err_code, 1, type: :fixed32
  field :err_msg, 2, type: :string
end

defmodule Usp.AddResp.CreatedObjectResult.OperationStatus.OperationSuccess do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          instantiated_path: String.t(),
          param_errs: [Usp.AddResp.ParameterError.t()],
          unique_keys: %{String.t() => String.t()}
        }
  defstruct [:instantiated_path, :param_errs, :unique_keys]

  field :instantiated_path, 1, type: :string
  field :param_errs, 2, repeated: true, type: Usp.AddResp.ParameterError

  field :unique_keys, 3,
    repeated: true,
    type: Usp.AddResp.CreatedObjectResult.OperationStatus.OperationSuccess.UniqueKeysEntry,
    map: true
end

defmodule Usp.AddResp.CreatedObjectResult.OperationStatus.OperationSuccess.UniqueKeysEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Usp.AddResp.ParameterError do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          param: String.t(),
          err_code: non_neg_integer,
          err_msg: String.t()
        }
  defstruct [:param, :err_code, :err_msg]

  field :param, 1, type: :string
  field :err_code, 2, type: :fixed32
  field :err_msg, 3, type: :string
end

defmodule Usp.Delete do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          allow_partial: boolean,
          obj_paths: [String.t()]
        }
  defstruct [:allow_partial, :obj_paths]

  field :allow_partial, 1, type: :bool
  field :obj_paths, 2, repeated: true, type: :string
end

defmodule Usp.DeleteResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          deleted_obj_results: [Usp.DeleteResp.DeletedObjectResult.t()]
        }
  defstruct [:deleted_obj_results]

  field :deleted_obj_results, 1, repeated: true, type: Usp.DeleteResp.DeletedObjectResult
end

defmodule Usp.DeleteResp.DeletedObjectResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          requested_path: String.t(),
          oper_status: Usp.DeleteResp.DeletedObjectResult.OperationStatus.t() | nil
        }
  defstruct [:requested_path, :oper_status]

  field :requested_path, 1, type: :string
  field :oper_status, 2, type: Usp.DeleteResp.DeletedObjectResult.OperationStatus
end

defmodule Usp.DeleteResp.DeletedObjectResult.OperationStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          oper_status: {atom, any}
        }
  defstruct [:oper_status]

  oneof :oper_status, 0

  field :oper_failure, 1,
    type: Usp.DeleteResp.DeletedObjectResult.OperationStatus.OperationFailure,
    oneof: 0

  field :oper_success, 2,
    type: Usp.DeleteResp.DeletedObjectResult.OperationStatus.OperationSuccess,
    oneof: 0
end

defmodule Usp.DeleteResp.DeletedObjectResult.OperationStatus.OperationFailure do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          err_code: non_neg_integer,
          err_msg: String.t()
        }
  defstruct [:err_code, :err_msg]

  field :err_code, 1, type: :fixed32
  field :err_msg, 2, type: :string
end

defmodule Usp.DeleteResp.DeletedObjectResult.OperationStatus.OperationSuccess do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          affected_paths: [String.t()],
          unaffected_path_errs: [Usp.DeleteResp.UnaffectedPathError.t()]
        }
  defstruct [:affected_paths, :unaffected_path_errs]

  field :affected_paths, 1, repeated: true, type: :string
  field :unaffected_path_errs, 2, repeated: true, type: Usp.DeleteResp.UnaffectedPathError
end

defmodule Usp.DeleteResp.UnaffectedPathError do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          unaffected_path: String.t(),
          err_code: non_neg_integer,
          err_msg: String.t()
        }
  defstruct [:unaffected_path, :err_code, :err_msg]

  field :unaffected_path, 1, type: :string
  field :err_code, 2, type: :fixed32
  field :err_msg, 3, type: :string
end

defmodule Usp.Set do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          allow_partial: boolean,
          update_objs: [Usp.Set.UpdateObject.t()]
        }
  defstruct [:allow_partial, :update_objs]

  field :allow_partial, 1, type: :bool
  field :update_objs, 2, repeated: true, type: Usp.Set.UpdateObject
end

defmodule Usp.Set.UpdateObject do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          obj_path: String.t(),
          param_settings: [Usp.Set.UpdateParamSetting.t()]
        }
  defstruct [:obj_path, :param_settings]

  field :obj_path, 1, type: :string
  field :param_settings, 2, repeated: true, type: Usp.Set.UpdateParamSetting
end

defmodule Usp.Set.UpdateParamSetting do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          param: String.t(),
          value: String.t(),
          required: boolean
        }
  defstruct [:param, :value, :required]

  field :param, 1, type: :string
  field :value, 2, type: :string
  field :required, 3, type: :bool
end

defmodule Usp.SetResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          updated_obj_results: [Usp.SetResp.UpdatedObjectResult.t()]
        }
  defstruct [:updated_obj_results]

  field :updated_obj_results, 1, repeated: true, type: Usp.SetResp.UpdatedObjectResult
end

defmodule Usp.SetResp.UpdatedObjectResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          requested_path: String.t(),
          oper_status: Usp.SetResp.UpdatedObjectResult.OperationStatus.t() | nil
        }
  defstruct [:requested_path, :oper_status]

  field :requested_path, 1, type: :string
  field :oper_status, 2, type: Usp.SetResp.UpdatedObjectResult.OperationStatus
end

defmodule Usp.SetResp.UpdatedObjectResult.OperationStatus do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          oper_status: {atom, any}
        }
  defstruct [:oper_status]

  oneof :oper_status, 0

  field :oper_failure, 1,
    type: Usp.SetResp.UpdatedObjectResult.OperationStatus.OperationFailure,
    oneof: 0

  field :oper_success, 2,
    type: Usp.SetResp.UpdatedObjectResult.OperationStatus.OperationSuccess,
    oneof: 0
end

defmodule Usp.SetResp.UpdatedObjectResult.OperationStatus.OperationFailure do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          err_code: non_neg_integer,
          err_msg: String.t(),
          updated_inst_failures: [Usp.SetResp.UpdatedInstanceFailure.t()]
        }
  defstruct [:err_code, :err_msg, :updated_inst_failures]

  field :err_code, 1, type: :fixed32
  field :err_msg, 2, type: :string
  field :updated_inst_failures, 3, repeated: true, type: Usp.SetResp.UpdatedInstanceFailure
end

defmodule Usp.SetResp.UpdatedObjectResult.OperationStatus.OperationSuccess do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          updated_inst_results: [Usp.SetResp.UpdatedInstanceResult.t()]
        }
  defstruct [:updated_inst_results]

  field :updated_inst_results, 1, repeated: true, type: Usp.SetResp.UpdatedInstanceResult
end

defmodule Usp.SetResp.UpdatedInstanceFailure do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          affected_path: String.t(),
          param_errs: [Usp.SetResp.ParameterError.t()]
        }
  defstruct [:affected_path, :param_errs]

  field :affected_path, 1, type: :string
  field :param_errs, 2, repeated: true, type: Usp.SetResp.ParameterError
end

defmodule Usp.SetResp.UpdatedInstanceResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          affected_path: String.t(),
          param_errs: [Usp.SetResp.ParameterError.t()],
          updated_params: %{String.t() => String.t()}
        }
  defstruct [:affected_path, :param_errs, :updated_params]

  field :affected_path, 1, type: :string
  field :param_errs, 2, repeated: true, type: Usp.SetResp.ParameterError

  field :updated_params, 3,
    repeated: true,
    type: Usp.SetResp.UpdatedInstanceResult.UpdatedParamsEntry,
    map: true
end

defmodule Usp.SetResp.UpdatedInstanceResult.UpdatedParamsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Usp.SetResp.ParameterError do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          param: String.t(),
          err_code: non_neg_integer,
          err_msg: String.t()
        }
  defstruct [:param, :err_code, :err_msg]

  field :param, 1, type: :string
  field :err_code, 2, type: :fixed32
  field :err_msg, 3, type: :string
end

defmodule Usp.Operate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          command: String.t(),
          command_key: String.t(),
          send_resp: boolean,
          input_args: %{String.t() => String.t()}
        }
  defstruct [:command, :command_key, :send_resp, :input_args]

  field :command, 1, type: :string
  field :command_key, 2, type: :string
  field :send_resp, 3, type: :bool
  field :input_args, 4, repeated: true, type: Usp.Operate.InputArgsEntry, map: true
end

defmodule Usp.Operate.InputArgsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Usp.OperateResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          operation_results: [Usp.OperateResp.OperationResult.t()]
        }
  defstruct [:operation_results]

  field :operation_results, 1, repeated: true, type: Usp.OperateResp.OperationResult
end

defmodule Usp.OperateResp.OperationResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          operation_resp: {atom, any},
          executed_command: String.t()
        }
  defstruct [:operation_resp, :executed_command]

  oneof :operation_resp, 0
  field :executed_command, 1, type: :string
  field :req_obj_path, 2, type: :string, oneof: 0
  field :req_output_args, 3, type: Usp.OperateResp.OperationResult.OutputArgs, oneof: 0
  field :cmd_failure, 4, type: Usp.OperateResp.OperationResult.CommandFailure, oneof: 0
end

defmodule Usp.OperateResp.OperationResult.OutputArgs do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          output_args: %{String.t() => String.t()}
        }
  defstruct [:output_args]

  field :output_args, 1,
    repeated: true,
    type: Usp.OperateResp.OperationResult.OutputArgs.OutputArgsEntry,
    map: true
end

defmodule Usp.OperateResp.OperationResult.OutputArgs.OutputArgsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Usp.OperateResp.OperationResult.CommandFailure do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          err_code: non_neg_integer,
          err_msg: String.t()
        }
  defstruct [:err_code, :err_msg]

  field :err_code, 1, type: :fixed32
  field :err_msg, 2, type: :string
end

defmodule Usp.Notify do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          notification: {atom, any},
          subscription_id: String.t(),
          send_resp: boolean
        }
  defstruct [:notification, :subscription_id, :send_resp]

  oneof :notification, 0
  field :subscription_id, 1, type: :string
  field :send_resp, 2, type: :bool
  field :event, 3, type: Usp.Notify.Event, oneof: 0
  field :value_change, 4, type: Usp.Notify.ValueChange, oneof: 0
  field :obj_creation, 5, type: Usp.Notify.ObjectCreation, oneof: 0
  field :obj_deletion, 6, type: Usp.Notify.ObjectDeletion, oneof: 0
  field :oper_complete, 7, type: Usp.Notify.OperationComplete, oneof: 0
  field :on_board_req, 8, type: Usp.Notify.OnBoardRequest, oneof: 0
end

defmodule Usp.Notify.Event do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          obj_path: String.t(),
          event_name: String.t(),
          params: %{String.t() => String.t()}
        }
  defstruct [:obj_path, :event_name, :params]

  field :obj_path, 1, type: :string
  field :event_name, 2, type: :string
  field :params, 3, repeated: true, type: Usp.Notify.Event.ParamsEntry, map: true
end

defmodule Usp.Notify.Event.ParamsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Usp.Notify.ValueChange do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          param_path: String.t(),
          param_value: String.t()
        }
  defstruct [:param_path, :param_value]

  field :param_path, 1, type: :string
  field :param_value, 2, type: :string
end

defmodule Usp.Notify.ObjectCreation do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          obj_path: String.t(),
          unique_keys: %{String.t() => String.t()}
        }
  defstruct [:obj_path, :unique_keys]

  field :obj_path, 1, type: :string

  field :unique_keys, 2,
    repeated: true,
    type: Usp.Notify.ObjectCreation.UniqueKeysEntry,
    map: true
end

defmodule Usp.Notify.ObjectCreation.UniqueKeysEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Usp.Notify.ObjectDeletion do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          obj_path: String.t()
        }
  defstruct [:obj_path]

  field :obj_path, 1, type: :string
end

defmodule Usp.Notify.OperationComplete do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          operation_resp: {atom, any},
          obj_path: String.t(),
          command_name: String.t(),
          command_key: String.t()
        }
  defstruct [:operation_resp, :obj_path, :command_name, :command_key]

  oneof :operation_resp, 0
  field :obj_path, 1, type: :string
  field :command_name, 2, type: :string
  field :command_key, 3, type: :string
  field :req_output_args, 4, type: Usp.Notify.OperationComplete.OutputArgs, oneof: 0
  field :cmd_failure, 5, type: Usp.Notify.OperationComplete.CommandFailure, oneof: 0
end

defmodule Usp.Notify.OperationComplete.OutputArgs do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          output_args: %{String.t() => String.t()}
        }
  defstruct [:output_args]

  field :output_args, 1,
    repeated: true,
    type: Usp.Notify.OperationComplete.OutputArgs.OutputArgsEntry,
    map: true
end

defmodule Usp.Notify.OperationComplete.OutputArgs.OutputArgsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Usp.Notify.OperationComplete.CommandFailure do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          err_code: non_neg_integer,
          err_msg: String.t()
        }
  defstruct [:err_code, :err_msg]

  field :err_code, 1, type: :fixed32
  field :err_msg, 2, type: :string
end

defmodule Usp.Notify.OnBoardRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          oui: String.t(),
          product_class: String.t(),
          serial_number: String.t(),
          agent_supported_protocol_versions: String.t()
        }
  defstruct [:oui, :product_class, :serial_number, :agent_supported_protocol_versions]

  field :oui, 1, type: :string
  field :product_class, 2, type: :string
  field :serial_number, 3, type: :string
  field :agent_supported_protocol_versions, 4, type: :string
end

defmodule Usp.NotifyResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          subscription_id: String.t()
        }
  defstruct [:subscription_id]

  field :subscription_id, 1, type: :string
end
