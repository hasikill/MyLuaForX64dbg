require("api")

-- lua标准库
function luafiletest()
    file = io.open("A:/a.txt", "w")

    io.output(file)

    io.write("abcdex.asdflsjdfl")

    io.close(file)
end

-- c库部分函数
function cfiletest()
    local fp = fopen("A:/a.txt", "r+")

    local buf = malloc(128)
    memset(buf, 0, 128)
    local size = fread(buf, 1, 128, fp)
    api.log(buf)

    printf("hexstring: \r\n%s", mem.localmemhex(buf, size))

    free(buf)

    local str = 'asd123456'
    local ret = fwrite(str, string.len(str), 1, fp)
    printf("ret = %d\r\n", ret)
    fclose(fp)
end

--printf("path: %s\r\n", string.reverse(mod.mainpath()))
cfiletest()