require("api")

if (api.isdebugging() == false) then
    api.log("请在调试的时候运行.")
    return
end


if (mem.isvaild(api.ctx.eip())) then
    local buf = malloc(16)
    memset(buf, 0, 16)
    mem.read(api.ctx.eip(), buf, 16)
    printf("%s\r\n", mem.localmemhex(buf, 16))

    printf("%s\r\n", mem.remotememhex(api.ctx.eip(), 16))

    --在被调试进程申请一块内存
    local remoteBuf = mem.remotealloc(16)
    printf("remote address = %08X\r\n", remoteBuf)

    --写入数据
    mem.write(remoteBuf, buf, 16)

    --在内存窗口中转到
    local strCmd = "dump "..string.format("%08X", remoteBuf)
    api.log(strCmd)
    api.cmd(strCmd)

    --查看被调试进程栈信息
    printf("%s", mem.remotememhex(api.ctx.esp(), 10, 4, "\n"))

    --释放内存
    free(buf)
end