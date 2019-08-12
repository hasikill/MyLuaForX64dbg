require("api")

local hUser32 = GetModuleHandle("user32.dll")

printf("user32: %08X\r\n", hUser32)

local lpMessageBoxA = GetProcAddress(hUser32, "MessageBoxA")
printf("MessageBoxA: %08X\r\n", lpMessageBoxA)

-- 动态添加函数
DynamicAddFunc("box", lpMessageBoxA)

box(0, 0, 0, 0)