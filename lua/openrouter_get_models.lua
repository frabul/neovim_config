local Curl = require("plenary.curl")
local adapter_utils = require("codecompanion.utils.adapters")
local config = require("codecompanion.config")
local log = require("codecompanion.utils.log")
local _cache_expires
local _cache_file = vim.fn.tempname()
local _cached_models

---Return the cached models
---@params opts? table
local function models(opts)
  if opts and opts.last then
    return _cached_models[1]
  end
  return _cached_models
end

---Get a list of available OpenAI compatible models
---@params self CodeCompanion.Adapter
---@params opts? table
---@return table
local function get_models(self, opts)
  if _cached_models and _cache_expires and _cache_expires > os.time() then
    return models(opts)
  end

  _cached_models = {}

  local adapter = require("codecompanion.adapters").resolve(self)
  if not adapter then
    log:error("Could not resolve OpenAI compatible adapter in the `get_models` function")
    return {}
  end

  adapter_utils.get_env_vars(adapter)
  local url = adapter.env_replaced.url .. adapter.env_replaced.models_endpoint

  local headers = {
    ["content-type"] = "application/json",
  }
  if adapter.env_replaced.api_key then
    headers["Authorization"] = "Bearer " .. adapter.env_replaced.api_key
  end

  local ok, response, json

  ok, response = pcall(function()
    return Curl.get(url, {
      sync = true,
      headers = headers,
      insecure = config.adapters.http.opts.allow_insecure,
      proxy = config.adapters.http.opts.proxy,
    })
  end)
  if not ok then
    log:error("Could not get the OpenAI compatible models from " .. url .. ".\nError: %s", response)
    return {}
  end

  ok, json = pcall(vim.json.decode, response.body)
  if not ok then
    log:error("Could not parse the response from " .. url)
    return {}
  end

  for _, jmodel in ipairs(json.data) do
    local resoning_options = vim.iter(jmodel.supported_parameters):any(function(k, v)
      return k == "reasoning" or v == "reasoning"
    end)
    local tools = vim.iter(jmodel.supported_parameters):any(function(k, v)
      return k == "tools" or v == "tools"
    end)
    local model = {
      id = jmodel.id,
      opts = {
        can_reason = resoning_options,
        tools = tools,
      },
    }
    table.insert(_cached_models, model)
  end
  _cached_models["dummy"] = { ["id"] = "dummy" }

  _cache_expires = adapter_utils.refresh_cache(_cache_file, config.adapters.http.opts.cache_models_for)

  return models(opts)
end

return get_models
