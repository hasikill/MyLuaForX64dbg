-- 导入调试API模块
require("api")

printf("Main OEP = 0x%x \r\n", mod.mainoep())
printf("Main base = 0x%x \r\n", mod.mainbase())
printf("Main size = 0x%x \r\n", mod.mainsize())
printf("Main name = %s \r\n", mod.mainname())
printf("Main path = %s \r\n", mod.mainpath())
printf("0x401800 base = 0x%x, size = 0x%x, oep = 0x%x \r\n", 
		mod.getbasebyaddr(0x401800), 
		mod.getsizebyaddr(0x401800),
		mod.getoepbyaddr(0x401800))
printf("ntdll.dll base = 0x%x, size = 0x%x, oep = 0x%x \r\n", 
		mod.getbasebyname("ntdll.dll"), 
		mod.getsizebyname("ntdll.dll"),
		mod.getoepbyname("ntdll.dll"))

printf("MessageBoxA addr = 0x%x\r\n", mod.getprocaddr("user32.dll", "MessageBoxA"))

-- 寄存器
printf("eax = %08X  ebx = %08X  ecx = %08X  edx = %08X\r\nebp = %08X  esp = %08X  edi = %08X  esi = %08X \r\n\teip = %08X\r\n", 
		api.ctx.eax(),
		api.ctx.ebx(),
		api.ctx.ecx(),
		api.ctx.edx(),
		api.ctx.ebp(),
		api.ctx.esp(),
		api.ctx.edi(),
		api.ctx.esi(),
		api.ctx.eip()
	)

printf("%d\r\n", api.ctx.esi())

-- 遍历模块
local tb = mod.getmdlist()
if (tb ~= nil)  then
	local count = tb['count']
	local list = tb['list']
	for i = 0, count - 1 do
		printf("base = %08X, name = %s \r\n", list[i]['base'], list[i]['name'])
	end
end
