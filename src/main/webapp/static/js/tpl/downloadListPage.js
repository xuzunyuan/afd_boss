var searchDate = "";
var hoursList, contextPath;

function showDatas() {
    var suffix = ".xlsx";
    var uri = contextPath + "/ems/download/";
    var fmtDate = getFmtDate();
    var table = $("#myTable");
    var tbody = table.find("thead");
    var prefix = "一网全城订单发货明细";
    tbody.html("");
    var tr = "<tr style='#BGCOLOR'><td>#COUNT</td><td>#FILENAME</td><td>#CREATETIME</td><td><a class='code' href='#URL' target='_blank'>#DOWNLOAD</a></td></tr>";
    var tr2 = "<tr><td colspan='4'>暂无数据！</td></tr>";
    var tr3 = "<tr><td colspan='4'>当日无数据！</td></tr>";
    var url, createtime, temp, count = 1;
    var maxHH = getMaxHH();

    if(-1 == maxHH) {
        tbody.append(tr2);
        return;
    }

    if(0 < maxHH && 0 === hoursList.length) {
        tbody.append(tr3);
        return;
    }

    var fmtHH, fileName;
    for (var i = 0; i < maxHH; i++) {
        fmtHH = fillZero(i);
        if(existFile(fmtHH)) {
            fileName = prefix + fmtDate + "_" + fmtHH + suffix;
            url = uri + fmtDate + "/" + fileName;
            createtime = fmtDate + " " + fmtHH + ":00:00";
            temp = tr.replace("#COUNT", count)
                .replace("#FILENAME", fileName)
                .replace("#CREATETIME", createtime)
                .replace("#URL", url)
                .replace("#DOWNLOAD", "下载");
            if (0 == count % 2)
                temp = temp.replace("#BGCOLOR", "background-color:rgb(241,241,241);");
            else
                temp = temp.replace("#BGCOLOR", "");
            tbody.append(temp);
            count++;
        }
    }
}

function existFile(hh) {
    for(var i=0; i<hoursList.length; i++) {
        if(eval(hh) === eval(hoursList[i])) return true;
    }
    return false;
}

function getFmtDate() {
    if ("" == searchDate) {
        searchDate = getCurrFmtDate();
    }

    return searchDate;
}

function getMaxHH() {
    var searchDateNum = searchDate.replace(/-/g, "");
    var currDateNum = getCurrFmtDate().replace(/-/g, "");

    if (eval(searchDateNum) < eval(currDateNum)) return 24;
    if (eval(searchDateNum) > eval(currDateNum)) return -1;
    return eval(getCurrFmtHH());
}

// 得到当前日期
function getCurrFmtDate() {
    var date = new Date();
    return date.getFullYear() + "-" + fillZero(date.getMonth() + 1) + "-" + fillZero(date.getDate() + 1);
}

// 得到当前小时
function getCurrFmtHH() {
    var date = new Date();
    return fillZero(date.getHours());
}

function fillZero(number) {
    if (eval(10) > eval(number)) return "0" + number;
    return number;
}