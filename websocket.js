
(function () {
    'use strict';
    if (Date.prototype.format == null) {
        Date.prototype.format = function (fmt) {
            var o = {
                "M+": this.getMonth() + 1, //月份
                "d+": this.getDate(), //日
                "h+": this.getHours(), //小时
                "m+": this.getMinutes(), //分
                "s+": this.getSeconds(), //秒
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度
                "S": this.getMilliseconds() //毫秒
            };
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        }
    }
    var path = require('path');
    var fs = require('fs');
    var ws = require("nodejs-websocket");
    var url = require('url');
    var os = require('os');
    var ip = "";
    var network = os.networkInterfaces();
    for(var i = 0; i < network.en1.length; i++) {
        var json = network.en1[i];
        if(json.family == 'IPv4') {
            ip = json.address;
        }
    }
    
    function exits(path){
        try{
            fs.accessSync(path,fs.F_OK);
        }catch(e){
            return false;
        }
        return true
    }
    let logspath = path.join(__dirname, "logs")
    if(!exits(logspath)){fs.mkdirSync(logspath);}

    function getLogPath(req, name) {
        let _log = path.join(req, "logs")
        return path.join(_log, name)
    }
    var server = ws.createServer(function (conn) {
        var name = new Date().format("yyyy-MM-dd hh-mm-ss") + ".log"
        conn.onopen = function (e) {
            console.log("连接服务器成功", e);
        }
        conn.on("text", function (str) {
            let logPath = getLogPath(__dirname, name)
            var source = JSON.parse(str)
            let _url = source.url
            let query = url.parse(decodeURI(_url), true).query
            source = { ...source, query }
            console.log("接受数据")
            fs.appendFileSync(logPath, `==========${_url}==========\r\n${JSON.stringify(source, null, 2)}\r\n`)
        })
        conn.on("close", function (code, reason) {
            console.log("关闭连接", code, reason)

        });
        conn.on("error", function (code, reason) {
            console.log("异常关闭")
        });
    }).listen(8888)
    console.log(`开始监听(${ip}:8888a111)`)
})();