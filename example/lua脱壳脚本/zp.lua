-- 导入调试API模块
require("api")

api.cls()
api.log("~~~~~~~~~~~~~~~~~~ZP脱壳脚本~~~~~~~~~~~~~~~~~~~")
api.log("使用教程: 在OEP处运行此脚本即可")
api.log("-- CR32 GSP\r\n\r\n\r\n")

--检查
if (api.isdebugging()) then
    --检查
    if (api.isrunning()) then
        api.log("不能在运行的状态下执行此脚本.")
        return
    end

    --检查
    if (api.ctx.eip() ~= mod.mainoep()) then
        api.log("请在OEP处运行脚本.")
        return
    end

    -- 开始脱壳
    -- 1. ESP定律
    api.clearbp()

    -- 单步一次
    api.stepinto() 

    -- 对ESP下硬件访问断点
    local esp = api.ctx.esp()
    api.sethbp(esp, "r", 1) 

    -- 运行
    api.go() 

    --等待调试事件到来
    api.wait()

    --清除上次硬件断点
    api.delhbp(esp)

    --单步12次到 OEP
    api.stepinto(12)

    --保存真实OEP
    local RealOEP = api.ctx.eip()
    if (mem.byte(RealOEP) == 0x55) then
        printf("已找到真实OEP: 0x%08X\r\n", RealOEP)
    else
        log.printf("脱壳出现异常，可能此壳并非ZP壳.")
    end
    

    -- 获取真实IAT
    local tmp = mem.dword(RealOEP + 0x37)
    printf("tmp = %x \r\n", tmp)

    local jmpaddr = mem.getjmpaddr(mem.dword(tmp) + 5)
    printf("jmpaddr = %x \r\n", jmpaddr)

    local jmpaddr2 = mem.getjmpaddr(jmpaddr)
    printf("jmpaddr2 = %x \r\n", jmpaddr2)

    --下断点
    api.setbp(jmpaddr2 + 0xd)

    --循环获取IAT
    for i = 0, 100 do
        --go
        api.go()
        api.wait()

        --原IAT
        local curEsp = api.ctx.esp()
        local rawIat = mem.dword(mem.dword(curEsp + 4) - 4)
        local newIat = mem.dword(curEsp)

        --修复IAT
        if (mem.byte(newIat) == 0xeb) then
            newIat = mem.dword(newIat + mem.byte(newIat + 1) + 2 + 2)
            newIat = mem.dword(newIat)
        end
        mem.dword(rawIat, newIat)

        --输出调试信息
        printf("rawIat = %08X, newIat = %08X\r\n", rawIat, newIat)
    end

    api.log("Finish.")

    --完成操作, 清除所有断点
    api.clearbp()
else
    api.log("请在调试的情况下运行此脚本!")
end