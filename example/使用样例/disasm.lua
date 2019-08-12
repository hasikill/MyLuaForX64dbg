-- 导入调试API模块
require("api")

-- 反汇编
ins = api.disasm(api.ctx.eip())
args = ins["args"]
print(ins)
printf("instrction: %s\r\n", ins["ins"])
printf("size: %d\r\n", ins["instr_size"])
printf("argcount : %d\r\n", args['count'])
for i = 0, args['count'] - 1 do
    printf("%s ", args[i])
end