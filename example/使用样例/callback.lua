-- 导入调试API模块
require("api")

---@param strExeName string 被调试进程的名称
function callback_initdbg(strExeName)
    printf("Hello %s\r\n", strExeName)
end


callback.evtinitdbg("callback_initdbg")