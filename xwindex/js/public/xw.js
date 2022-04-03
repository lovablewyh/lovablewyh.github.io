function siteTime(){
        window.setTimeout("siteTime()", 1000);
        var seconds = 1000;
        var minutes = seconds * 60;
        var hours = minutes * 60;
        var days = hours * 24;
        var years = days * 365;
        var today = new Date();
        var todayYear = today.getFullYear();
        var todayMonth = today.getMonth()+1;
        var todayDate = today.getDate();
        var todayHour = today.getHours();
        var todayMinute = today.getMinutes();
        var todaySecond = today.getSeconds();
        /* Date.UTC() -- 返回date对象距世界标准时间(UTC)1970年1月1日午夜之间的毫秒数(时间戳)
        year - 作为date对象的年份，为4位年份值
        month - 0-11之间的整数，做为date对象的月份
        day - 1-31之间的整数，做为date对象的天数
        hours - 0(午夜24点)-23之间的整数，做为date对象的小时数
        minutes - 0-59之间的整数，做为date对象的分钟数
        seconds - 0-59之间的整数，做为date对象的秒数
        microseconds - 0-999之间的整数，做为date对象的毫秒数 */
        var t1 = Date.UTC(2020,01,01,00,00,00); //北京时间2016-12-1 00:00:00
        var t2 = Date.UTC(todayYear,todayMonth,todayDate,todayHour,todayMinute,todaySecond);
        var diff = t2-t1;
        var diffYears = Math.floor(diff/years);
        var diffDays = Math.floor((diff/days)-diffYears*365);
        var diffHours = Math.floor((diff-(diffYears*365+diffDays)*days)/hours);
        var diffMinutes = Math.floor((diff-(diffYears*365+diffDays)*days-diffHours*hours)/minutes);
        var diffSeconds = Math.floor((diff-(diffYears*365+diffDays)*days-diffHours*hours-diffMinutes*minutes)/seconds);
        document.getElementById("sitetime").innerHTML=" 站长站点已运行 "+diffYears+" 年 "+diffDays+" 天 "+diffHours+" 小时 "+diffMinutes+" 分钟 "+diffSeconds+" 秒</br>";
    }
		siteTime();
		
		function data(){
		 var xwzs = new Date();
		 var hour = xwzs.getHours();
			if ((hour>5)&&(hour<=7))
				document.write("惟仪涵提醒您：早上好,美好的一天开始了");			
			else if ((hour>7)&&(hour<11))
				document.write("惟仪涵提醒您：上午好，一定会干劲十足的");	
			else if ((hour=>11)&&(hour<13))
				document.write("惟仪涵提醒您：中午好,注意吃饭和休息哦");		
			else if ((hour=>13)&&(hour<17)) 
				document.write("惟仪涵提醒您：下午好！记得来杯下午茶哦");
			else if ((hour=>17)&&(hour<=19)) 
				document.write("惟仪涵提醒您：傍晚了，休闲娱乐开始喽");	
			else if ((hour>19)&&(hour<=22)) 
				document.write("惟仪涵提醒您：晚上好，注意少熬夜了哦");	
			else  document.write("惟仪涵提醒您：夜深了，该休息了哦");	
		}
		data();//调用函数
		
	function htmlScroll() {
	    var top = document.body.scrollTop || document.documentElement.scrollTop;
	    if (elFix.data_top < top) {
	        elFix.style.position = 'fixed';
	        elFix.style.top = 0;
	        elFix.style.left = elFix.data_left;
	    }
	    else {
	        elFix.style.position = 'static';
	    }
	}
	
	function htmlPosition(obj) {
	    var o = obj;
	    var t = o.offsetTop;
	    var l = o.offsetLeft;
	    while (o = o.offsetParent) {
	        t += o.offsetTop;
	        l += o.offsetLeft;
	    }
	    obj.data_top = t;
	    obj.data_left = l;
	}