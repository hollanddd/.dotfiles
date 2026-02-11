
local getos = {}

function getos.is_wsl()
  local env = os.getenv("WSL_INTEROP")
  return string.len(env or "") > 2
end

function getos.get_name()
  local osname
  -- as luajit first
  if jit then
    return jit.os
  end

  -- *nix
  local fh, err = assert(io.popen("uname -o 2>/dev/null", "r"))
  if fh then
    osname = fh:read()
  end
  return osname or "windows"
end

return getos
