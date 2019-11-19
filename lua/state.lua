
function getFileName()
    local patientId  = ngx.var.patientId
    local clientProductId  = ngx.var.clientProductId
    local outFile = string.format("/usr/share/nginx/html/files/state/%s_%s.json",patientId,clientProductId)
    return outFile
end

local cjson = require "cjson"

if ngx.req.get_method() == "POST" or ngx.req.get_method() == "PUT"  then

    ngx.req.read_body()
    local body = cjson.decode(ngx.req.get_body_data())

    local file = io.open(getFileName(), 'w')
    file:write(cjson.encode(body))
    file:close()
    return 200
else
    local file = io.open(getFileName(), 'r')
    local body = file:read()
    ngx.say(body)
    file:close()
end


