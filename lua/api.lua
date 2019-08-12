api = {}

--单步步入
-- count: 单步的次数
function api.stepinto(count)
	if (count == nil) then
		count = " 1"
	elseif (type(count) == "number") then
		count = " "..string.format("%x", count)
	else
		api.log("count 无效参数类型")
	end

	api.cmd("StepInto"..count)
	Sleep(10)
end

--单步步过
-- count: 单步的次数
function api.stepover(count)
	if (count == nil) then
		count = " 1"
	elseif (type(count) == "number") then
		count = " "..string.format("%x", count)
	else
		api.log("count 无效参数类型")
	end
	DbgCmdExec("StepOver"..count)
	Sleep(10)
end

--单步跳出
-- count: 单步的次数
function api.stepOut(count)
	if (count == nil) then
		count = " 1"
	elseif (type(count) == "number") then
		count = " "..string.format("%x", count)
	else
		api.log("count 无效参数类型")
	end
	StepOut()
	Sleep(10)
end

-- 等待调试事件
function api.wait()
	Wait()
end

--暂停
function api.pause()
	Pause()
end

--停止调试
function api.stop()
	api.cmd("stop")
end

--判断运行状态
function api.isrunning()
	return DbgIsRunning()
end

--清除所有断点
function api.clearbp()
	api.cmd("bpc")
end

--设置软件断点
function api.setbp(addr)
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("下断点只能在调试的状态下使用.")
		return false
	end
	
	--判断是否是整数地址
	if (type(addr) == "number")
	then
		--把整数转换为字符串 并 执行命令
		api.cmd("bp "..string.format("%x", addr))
		return true
	elseif(type(addr) == "string")
	then
		--执行断点命令
		api.cmd("bp "..addr)
		return true
	else
		api.log("不支持的数据类型")
		return false
	end
end

--删除软件断点
function api.delbp(addr)
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("删除断点只能在调试的状态下使用.")
		return false
	end
	
	--判断是否是整数地址
	if (type(addr) == "number")
	then
		--把整数转换为字符串 并 执行命令
		api.cmd("bpc "..string.format("%x", addr))
		return true
	elseif(type(addr) == "string")
	then
		--执行删除断点命令
		api.cmd("bpc "..addr)
		return true
	else
		api.log("不支持的数据类型")
		return false
	end
end

--启用软件断点
function api.enablebp(addr)
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("启用软件断点只能在调试的状态下使用.")
		return false
	end
	
	--判断是否是整数地址
	if (type(addr) == "number")
	then
		--把整数转换为字符串 并 执行命令
		api.cmd("bpe "..string.format("%x", addr))
		return true
	elseif(type(addr) == "string")
	then
		--执行断点命令
		api.cmd("bpe "..addr)
		return true
	else
		api.log("不支持的数据类型")
		return false
	end
end

--禁用软件断点
function api.disablebp(addr)
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("禁用软件断点只能在调试的状态下使用.")
		return false
	end
	
	--判断是否是整数地址
	if (type(addr) == "number")
	then
		--把整数转换为字符串 并 执行命令
		api.cmd("bpd "..string.format("%x", addr))
		return true
	elseif(type(addr) == "string")
	then
		--执行断点命令
		api.cmd("bpd "..addr)
		return true
	else
		api.log("不支持的数据类型")
		return false
	end
end

--设置硬件断点
-- t : r w x 读 写 执行 默认x
-- size: 1 2 4 (8 只能在 64位下) 默认1
function api.sethbp(addr, t, size)
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("下断点只能在调试的状态下使用.")
		return false
	end

	if (t == nil)
	then
		t = ",x"
	elseif(type(t) == "string")
	then
		t = ","..t
	else
		api.log("t不支持的数据类型")
	end

	if (size == nil)
	then
		size = ",1"
	elseif(type(size) == "string" or type(size) == "number")
	then
		size = ","..size
	else
		api.log("size不支持的数据类型")
	end
	
	--判断是否是整数地址
	if (type(addr) == "number")
	then
		--把整数转换为字符串 并 执行命令
		api.cmd("bph "..string.format("%x", addr)..t..size)
		return true
	elseif(type(addr) == "string")
	then
		--执行断点命令
		api.cmd("bph "..addr..t..size)
		return true
	else
		api.log("不支持的数据类型")
		return false
	end
end

--删除硬件断点
function api.delhbp(addr)
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("删除硬件断点只能在调试的状态下使用.")
		return false
	end
	
	--判断是否是整数地址
	if (type(addr) == "number")
	then
		--把整数转换为字符串 并 执行命令
		api.cmd("bphc "..string.format("%x", addr))
		return true
	elseif(type(addr) == "string")
	then
		--执行删除断点命令
		api.cmd("bphc "..addr)
		return true
	else
		api.log("不支持的数据类型")
		return false
	end
end

--启用硬件断点
function api.enablehbp(addr)
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("启用硬件断点只能在调试的状态下使用.")
		return false
	end
	
	--判断是否是整数地址
	if (type(addr) == "number")
	then
		--把整数转换为字符串 并 执行命令
		api.cmd("bphe "..string.format("%x", addr))
		return true
	elseif(type(addr) == "string")
	then
		--执行断点命令
		api.cmd("bphe "..addr)
		return true
	else
		api.log("不支持的数据类型")
		return false
	end
end

--禁用硬件断点
function api.disablehbp(addr)
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("禁用硬件断点只能在调试的状态下使用.")
		return false
	end
	
	--判断是否是整数地址
	if (type(addr) == "number")
	then
		--把整数转换为字符串 并 执行命令
		api.cmd("bphd "..string.format("%x", addr))
		return true
	elseif(type(addr) == "string")
	then
		--执行断点命令
		api.cmd("bphd "..addr)
		return true
	else
		api.log("不支持的数据类型")
		return false
	end
end

--设置内存断点
-- addr : 断点地址
-- time : 是一次性断点还是永久断点 默认永久
-- t : a r w x r读 w写 x执行 a(rwx)
function api.setmbp(addr, time, t)
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("设置内存断点只能在调试的状态下使用.")
		return false
	end

	--默认无限次数断点
	if (time == nil)
	then
		time = ""
	elseif(type(time) == "boolean")
	then
		time = time and ",1" or ",0"
	else
		api.log("time不支持的数据类型")
		return false
	end

	--默认读断点
	if (t == nil)
	then
		t = ",r"
	elseif(type(t) ~= "string")
	then
		api.log("t不支持的数据类型")
		return false
	else
		t = ","..t
	end
	
	--判断是否是整数地址
	if (type(addr) == "number")
	then
		--把整数转换为字符串 并 执行命令
		api.cmd("bpm "..string.format("%x", addr)..time..t)
		return true
	elseif(type(addr) == "string")
	then
		--执行断点命令
		api.cmd("bpm "..addr..time..t)
		return true
	else
		api.log("不支持的数据类型")
		return false
	end
end

--删除内存断点
function api.delmbp(addr)
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("删除内存断点只能在调试的状态下使用.")
		return false
	end
	
	--判断是否是整数地址
	if (type(addr) == "number")
	then
		--把整数转换为字符串 并 执行命令
		api.cmd("bpmc "..string.format("%x", addr))
		return true
	elseif(type(addr) == "string")
	then
		--执行删除断点命令
		api.cmd("bpmc "..addr)
		return true
	else
		api.log("不支持的数据类型")
		return false
	end
end

--启用内存断点
function api.enablembp(addr)
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("启用内存断点只能在调试的状态下使用.")
		return false
	end
	
	--判断是否是整数地址
	if (type(addr) == "number")
	then
		--把整数转换为字符串 并 执行命令
		api.cmd("bpme "..string.format("%x", addr))
		return true
	elseif(type(addr) == "string")
	then
		--执行断点命令
		api.cmd("bpme "..addr)
		return true
	else
		api.log("不支持的数据类型")
		return false
	end
end

--禁用内存断点
function api.disablembp(addr)
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("禁用内存断点只能在调试的状态下使用.")
		return false
	end
	
	--判断是否是整数地址
	if (type(addr) == "number")
	then
		--把整数转换为字符串 并 执行命令
		api.cmd("bpmd "..string.format("%x", addr))
		return true
	elseif(type(addr) == "string")
	then
		--执行断点命令
		api.cmd("bpmd "..addr)
		return true
	else
		api.log("不支持的数据类型")
		return false
	end
end

--运行被调试程序
function api.go()
	--是否正在调试
	if(not(api.isdebugging()))
	then
		api.log("运行只能在调试的状态下使用.")
		return false
	end
	api.cmd("go")
end

--输出调试信息
function api.log(str)
	logputs(str)
end

--清屏
function api.cls()
	api.cmd("cls")
	Sleep(10)
end

--消息框
function api.msgbox(title, msg)
	MessageBoxA(0, msg, title, 0)
end

--获取当前调试线程tid
function api.curtid()
	return DbgGetThreadId()
end

--获取当前调试进程pid
function api.curpid()
	return DbgGetProcessId()
end

--获取当前调试进程peb
function api.peb()
	return DbgGetPebAddress(DbgGetProcessId())
end

--获取当前调试线程teb
function api.teb()
	return DbgGetTebAddress(DbgGetThreadId())
end

--执行命令
function api.cmd(strCmd)
	local ret = DbgCmdExec(strCmd)
	Sleep(10)
	return ret
end

--调试器是否正在调试状态
function api.isdebugging()
	return DbgIsDebugging()
end

--反汇编一条指令
-- addr 被调试进程的地址，可以是整数或者是十六进制的文本地址
-- ret 返回一个指令对象，格式如下
--  {
-- 	 "ins" : "mov eax, ecx",
-- 	 "instr_size" : 2,
-- 	 "args" : {
-- 		 "count" : 2,
-- 		 0 : "eax",
-- 	     1 : "ecx"
-- 	 }
--  }
function api.disasm(addr)
	if (type(addr) == "string") then
		addr = tonumber(addr, 16)
	elseif (type(addr) ~= "number") then
		error("addr 无效参数类型")
		return nil
	end

	return DbgDisasm()
end


--文本输入框  注意 ： 慎用 此函数有bug,与输入法冲突可能会引起程序崩溃
-- label 提示信息
-- title 窗口标题
-- ret 输入的内容
function api.input(label, title)
	if (type(label) ~= "string") then
		error("label必须为string类型")
		return nil
	end

	if (title == nil) then
		title = "title"
	end

	return InputBox(label, title)
end

--整数输入框  注意: 慎用 此函数有bug,与输入法冲突可能会引起程序崩溃
-- label 提示信息
-- title 窗口标题
-- ret 返回输入的10进制数
function api.inputnum(label, title)
	if (type(label) ~= "string") then
		error("label必须为string类型")
		return nil
	end

	if (title == nil) then
		title = "title"
	end

	local str = InputBox(label, title)
	if (str ~= nil) then
		local num = tonumber(str, 10)
		return num
	else
		return nil
	end
end

--刷新UI 需修复
function api.flushui()
	Refresh()
end

------------------------------------------- 寄存器相关 -----------------------------------------------
api.ctx = {}

-- Eax
function api.ctx.eax(val)
	if (val == nil)
	then
		return GetEax()
	elseif (type(val) == "number")
	then
		return SetEax(val)
	elseif (type(val) == "string")
	then
		return SetEax(tonumber(val, 16))
	else
		api.log("val无效的参数类型.")
		return false;
	end
end

-- Ebx
function api.ctx.ebx(val)
	if (val == nil)
	then
		return GetEbx()
	elseif (type(val) == "number")
	then
		return SetEbx(val)
	elseif (type(val) == "string")
	then
		return SetEbx(tonumber(val, 16))
	else
		api.log("val无效的参数类型.")
		return false;
	end
end

-- Ecx
function api.ctx.ecx(val)
	if (val == nil)
	then
		return GetEcx()
	elseif (type(val) == "number")
	then
		return SetEcx(val)
	elseif (type(val) == "string")
	then
		return SetEcx(tonumber(val, 16))
	else
		api.log("val无效的参数类型.")
		return false;
	end
end

-- Edx
function api.ctx.edx(val)
	if (val == nil)
	then
		return GetEdx()
	elseif (type(val) == "number")
	then
		return SetEdx(val)
	elseif (type(val) == "string")
	then
		return SetEdx(tonumber(val, 16))
	else
		api.log("val无效的参数类型.")
		return false;
	end
end

-- Ebp
function api.ctx.ebp(val)
	if (val == nil)
	then
		return GetEbp()
	elseif (type(val) == "number")
	then
		return SetEbp(val)
	elseif (type(val) == "string")
	then
		return SetEbp(tonumber(val, 16))
	else
		api.log("val无效的参数类型.")
		return false;
	end
end

-- Esp
function api.ctx.esp(val)
	if (val == nil)
	then
		return GetEsp()
	elseif (type(val) == "number")
	then
		return SetEsp(val)
	elseif (type(val) == "string")
	then
		return SetEsp(tonumber(val, 16))
	else
		api.log("val无效的参数类型.")
		return false;
	end
end

-- Esi
function api.ctx.esi(val)
	if (val == nil)
	then
		return GetEsi()
	elseif (type(val) == "number")
	then
		return SetEsi(val)
	elseif (type(val) == "string")
	then
		return SetEsi(tonumber(val, 16))
	else
		api.log("val无效的参数类型.")
		return false;
	end
end

-- Edi
function api.ctx.edi(val)
	if (val == nil)
	then
		return GetEdi()
	elseif (type(val) == "number")
	then
		return SetEdi(val)
	elseif (type(val) == "string")
	then
		return SetEdi(tonumber(val, 16))
	else
		api.log("val无效的参数类型.")
		return false;
	end
end

-- Eip
function api.ctx.eip(val)
	if (val == nil)
	then
		return GetEip()
	elseif (type(val) == "number")
	then
		return SetEip(val)
	elseif (type(val) == "string")
	then
		return SetEip(tonumber(val, 16))
	else
		api.log("val无效的参数类型.")
		return false;
	end
end

----------------------------------------------- 模块相关 --------------------------------------------------
mod = {}

-- 主模块 OEP
function mod.mainoep()
	return GetMainModuleEntry()
end

-- 主模块基址
function mod.mainbase()
	return GetMainModuleBase()
end

-- 主模块大小
function mod.mainsize()
	return GetMainModuleSize()
end

-- 主模块名称
function mod.mainname()
	return GetMainModuleName()
end

-- 主模块路径
function mod.mainpath()
	return GetMainModulePath()
end

-- 根据地址查找属于该模块的基址
-- addr: 被调试进程地址
-- ret: 返回对应模块的基址
function mod.getbasebyaddr(addr)
	if (type(addr) == "number")
	then
		return BaseFromAddr(addr)
	elseif (type(addr) == "string")
	then
		return BaseFromAddr(tonumber(addr, 16))
	else
		api.log("addr无效的参数类型.")
		return false;
	end
end

--根据模块名称查找模块基址
-- name: 模块名称
-- ret: 返回对应模块的基址
function mod.getbasebyname(name)
	if (type(name) == "string") then
		return BaseFromName(name)
	else
		api.log("name无效的参数类型.")
		return false;
	end
end

-- 根据地址查找属于该模块的大小
-- addr: 被调试进程地址
-- ret: 返回对应模块的大小
function mod.getsizebyaddr(addr)
	if (type(addr) == "number") then
		return SizeFromAddr(addr)
	elseif (type(addr) == "string") then
		return SizeFromAddr(tonumber(addr, 16))
	else
		api.log("addr无效的参数类型.")
		return false;
	end
end

--根据模块名称查找模块大小
-- name: 模块名称
-- ret: 返回对应模块的大小
function mod.getsizebyname(name)
	if (type(name) == "string") then
		return SizeFromName(name)
	else
		api.log("name无效的参数类型.")
		return false;
	end
end

-- 根据地址查找属于该模块的OEP
-- addr: 被调试进程地址
-- ret: 返回对应模块的OEP
function mod.getoepbyaddr(addr)
	if (type(addr) == "number") then
		return EntryFromAddr(addr)
	elseif (type(addr) == "string") then
		return EntryFromAddr(tonumber(addr, 16))
	else
		api.log("addr无效的参数类型.")
		return false;
	end
end

--根据模块名称查找模块OEP
-- name: 模块名称
-- ret: 返回对应模块的OEP
function mod.getoepbyname(name)
	if (type(name) == "string") then
		return EntryFromName(name)
	else
		api.log("name无效的参数类型.")
		return false;
	end
end

--查询WIN API地址
-- md: 模块名称
-- api: 函数名称
-- ret: 返回函数地址
function mod.getprocaddr(md, api)
	if (type(md) == "string" and type(api) == "string") then
		return RemoteGetProcAddress(md, api)
	else
		api.log("md api无效的参数类型.")
		return false;
	end
end

--遍历模块
-- 成功返回模块对象数组, 失败返回 nil
-- 对象结构
-- {
-- 	count : 2,
-- 	list : [
-- 		{
-- 			"base" : 401000,
-- 			"oep" : 401000,
-- 			"size" : 3000,
-- 			"name" : "xx.exe",
-- 			"path" : "C:/xx.exe",
-- 			"sectionCount" : 3
-- 		},
-- 		{
-- 			"base" : 401000,
-- 			"oep" : 401000,
-- 			"size" : 3000,
-- 			"name" : "xx.dll",
-- 			"path" : "C:/xx.dll",
-- 			"sectionCount" : 3
-- 		}
-- 	]
-- }
-- 遍历代码
-- local tb = mod.getmdlist()
-- check it
-- local count = tb['count']
-- local list = tb['list']
-- for i = 0, count - 1 do
-- 	print("base", list[i]['base'])
-- 	print("name", list[i]['name'])
-- end
function mod.getmdlist()
	if (not(api.isdebugging())) then
		return nil
	end
	-- 获取模块对象
	return GetModuleList()
end

------------------------------------ 内存操作 -----------------------------------------
mem = {}

-- 单字节操作
function mem.byte(addr, b)
	-- 地址检查
	if (type(addr) == "string") then
		addr = tonumber(addr, 16)
	elseif (type(addr) ~= "number") then
		error("addr is not number or string")
		return 0
	end

	--数值检查
	if (b == nil) then
		return ReadByte(addr)
	elseif (type(b) == "number") then
		return WriteByte(addr, b)
	else
		error("b is not a number")
		return false
	end
end

-- 字操作
function mem.word(addr, w)
	-- 地址检查
	if (type(addr) == "string") then
		addr = tonumber(addr, 16)
	elseif (type(addr) ~= "number") then
		error("addr is not number or string")
		return 0
	end

	--数值检查
	if (w == nil) then
		return ReadWord(addr)
	elseif (type(w) == "number") then
		return WriteWord(addr, w)
	else
		error("w is not a number")
		return false
	end
end

-- 双字操作
function mem.dword(addr, dw)
	-- 地址检查
	if (type(addr) == "string") then
		addr = tonumber(addr, 16)
	elseif (type(addr) ~= "number") then
		error("addr is not number or string")
		return 0
	end

	--数值检查
	if (dw == nil) then
		return ReadDword(addr)
	elseif (type(dw) == "number") then
		return WriteDword(addr, dw)
	else
		error("dw is not a number")
		return false
	end
end

-- 获取跳转地址
function mem.getjmpaddr(eip)
	if (type(eip) == "string") then
		eip = tonumber(eip, 16)
	elseif (type(eip) ~= "number") then
		error("eip is not number or string")
		return 0
	end

	return mem.dword(eip + 1) + eip + 5
end

-- 判断被调试进程地址是否有效
function mem.isvaild(addr)
	if (type(addr) == "string") then
		addr = tonumber(addr, 16)
	elseif (type(addr) ~= "number") then
		error("addr is not number or string")
		return nil
	end
	return IsValidPtr(addr)
end

-- 读取调试器进程的内存
function mem.read(dstva, buf, size)
	if (type(dstva) == "string") then
		dstva = tonumber(addr, 16)
	elseif (type(dstva) ~= "number") then
		error("dstva is not number or string")
		return nil
	end

	if (type(buf) ~= "number") then
		error("buf is not number")
		return nil
	end

	if (type(size) ~= "number") then
		error("size is not number")
		return nil
	end

	if (buf == 0) then
		error("buf is nullptr.")
		return nil
	end

	-- 检查被调试进程地址有效性
	if (mem.isvaild(dstva) == false) then
		error("dstva is invalid")
		return nil
	end

	return DbgMemRead(dstva, buf, size)
end

-- 写被调试进程内存
function mem.write(dstva, buf, size)
	if (type(dstva) == "string") then
		dstva = tonumber(addr, 16)
	elseif (type(dstva) ~= "number") then
		error("dstva is not number or string")
		return nil
	end

	if (type(buf) ~= "number") then
		error("buf is not number")
		return nil
	end

	if (type(size) ~= "number") then
		error("size is not number")
		return nil
	end

	if (buf == 0) then
		error("buf is nullptr.")
		return nil
	end

	-- 检查被调试进程地址有效性
	if (mem.isvaild(dstva) == false) then
		error("dstva is invalid")
		return nil
	end

	return DbgMemWrite(dstva, buf, size)
end

-- 在被调试进程中申请内存
function mem.remotealloc(size)
	if (type(size) ~= "number") then
		error("size is not number")
		return nil
	end
	return RemoteAlloc(0, size)
end

-- 释放被调试进程中申请的内存
function mem.remotefree(addr)
	if (type(addr) == "string") then
		addr = tonumber(addr, 16)
	elseif (type(addr) ~= "number") then
		error("addr is not number or string")
		return nil
	end
	return RemoteFree(addr)
end

-- 从调试器进程中获取一段内存，转化为hex string
function mem.localmemhex(addr, size, step, spacer)
	if (step == nil) then
		step = 1
	elseif (type(step) ~= "number") then
		error("step is not number")
		return nil
	end

	if (spacer == nil) then
		spacer = " "
	elseif (type(spacer) ~= "string") then
		error("spacer is not string")
		return nil
	end

	if (type(addr) == "string") then
		addr = tonumber(addr, 16)
	elseif (type(addr) ~= "number") then
		error("addr is not number or string")
		return nil
	end

	if (type(size) ~= "number") then
		error("size is not number")
		return nil
	end

	if (size > 255) then
		error("Size should not be greater than 255")
		return nil
	end

	return getmemhex(addr, size, step, spacer)
end

-- 从被调试器进程中获取一段内存，转化为hex string
function mem.remotememhex(addr, size, step, spacer)
	if (step == nil) then
		step = 1
	elseif (type(step) ~= "number") then
		error("step is not number")
		return nil
	end

	if (spacer == nil) then
		spacer = " "
	elseif (type(spacer) ~= "string") then
		error("spacer is not string")
		return nil
	end

	if (type(addr) == "string") then
		addr = tonumber(addr, 16)
	elseif (type(addr) ~= "number") then
		error("addr is not number or string")
		return nil
	end

	if (type(size) ~= "number") then
		error("size is not number")
		return nil
	end

	if (size > 255) then
		error("Size should not be greater than 255")
		return nil
	end

	if (mem.isvaild(addr) == false) then
		error("addr is invalid.")
		return nil
	end

	return getremotememhex(addr, size, step, spacer)
end

callback = {}

---@class EXCEPTION_DEBUG_INFO
---@field ExceptionCode number  异常代码
---@field ExceptionFlags number
---@field NextExceptionRecord number
---@field ExceptionAddress number 异常地址
---@field NumberParameters number   参数数量
---@field ExceptionInformation table 参数数组

-- 添加异常事件回调函数，被调试器进程产生异常将会调用添加的函数
-- luaFuncName 类型(string) lua函数的函数名称 ,函数声明如下
---@param e EXCEPTION_DEBUG_INFO 异常信息对象
-- function callback_exception(e)
-- end
-- ret 返回成功或者失败,true | false, 失败表示函数已经注册
function callback.evtexcept(luaFuncName)
	return AddCallBack_Exception(luaFuncName)
end

-- 添加停止调试事件回调函数，停止被调试器进程时回调
-- luaFuncName 类型(string) lua函数的函数名称 ,函数声明如下
-- function callback_stopdbg()
-- end
-- ret 返回成功或者失败,true | false, 失败表示函数已经注册
function callback.evtstopdbg(luaFuncName)
	return AddCallBack_StopDebug(luaFuncName)
end

-- 添加调试开始事件回调函数，进程被调试器打开或者附加时调用
---@param luaFuncName string lua函数的函数名称 ,函数声明如下
---@param strFilePath string 被调试进程的路径
-- function callback_initdbg(strFilePath)
-- end
-- ret 返回成功或者失败,true | false, 失败表示函数已经注册
function callback.evtinitdbg(luaFuncName)
	return AddCallBack_InitDebug(luaFuncName)
end

---@class DEBUG_EVENT
---@field dwDebugEventCode number 调试事件类型
---@field dwProcessId number 调试进程ID
---@field dwThreadId number 发生调试事件的线程ID

-- 添加调试事件回调函数，进程发生调试事件时调用
-- luaFuncName 类型(string) lua函数的函数名称 ,函数声明如下
---@param info string 调试信息对象
-- function callback_initdbg(info)
-- end
-- ret 返回成功或者失败,true | false, 失败表示函数已经注册
function callback.evtdbg(luaFuncName)
	return AddCallBack_DebugEvent(luaFuncName)
end

-- 清除之前添加的所有调试回调, 调用此函数之前所有的回调都将失效
function callback.clear()
	ClearCallBack()
end

return api, mod, mem, callback