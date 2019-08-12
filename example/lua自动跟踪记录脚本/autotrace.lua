-- 导入调试API模块
require("api")

api.cls()
api.log("~~~~~~~~~~~~~~~~~~自动跟踪脚本~~~~~~~~~~~~~~~~~~~")
api.log("使用教程: 在暂停的时候运行此脚本即可")
api.log("-- CR32 GSP\r\n\r\n\r\n")

--检查
if (api.isdebugging()) then
    --检查
    if (api.isrunning()) then
        api.log("不能在运行的状态下执行此脚本.")
        return
    end

    --开始
    local AutoTraceCount = api.inputnum("请输入需要跟踪的次数", "AutoTrace")
    if (AutoTraceCount == nil) then
        api.msgbox("error", "number is bad, faild")
        return
    end
    api.log("正在执行...")
    flushlog()

    --打开文件
    local strFile = "A:/trace.txt"
    local traceFile = io.open(strFile, "w")
    io.output(traceFile)

    --循环跟踪
    for i = 0, AutoTraceCount do
        io.write("Step: "..i.."\n")
        local eip = api.ctx.eip()
        local instr = api.disasm(eip)
        io.write(string.format("\t%08X\t%s\n", eip, instr['ins']))

        io.write("register:".."\n")
        io.write(string.format("eax = %08X  ebx = %08X  ecx = %08X  edx = %08X\nebp = %08X  esp = %08X  edi = %08X  esi = %08X \neip = %08X\n", 
		api.ctx.eax(),
		api.ctx.ebx(),
		api.ctx.ecx(),
		api.ctx.edx(),
		api.ctx.ebp(),
		api.ctx.esp(),
		api.ctx.edi(),
		api.ctx.esi(),
		api.ctx.eip()))

        --查看被调试进程栈信息
        io.write(string.format("Stack:\n%s", mem.remotememhex(api.ctx.esp(), 10, 4, "\n")))

        io.write("\r\n")

        -- 单步
        api.stepinto()
        Sleep(20)
    end

    --关闭文件
    io.close(traceFile)

    --Finish
    api.log("Auto Trace Finish.")
    api.msgbox("Finish", string.format("Auto trace success! path: %s", strFile))

    --完成操作, 清除所有断点
    api.clearbp()
else
    api.log("请在调试的情况下运行此脚本!")
end