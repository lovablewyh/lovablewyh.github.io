		function maskingKeyboard() {
		    if (event.ctrlKey) {
		        event.keyCode = 0;
		        event.returnValue = false;
		        alert("惟仪涵提醒你:当前设置不允许使用ctrl键哦,强制使用会我很伤心呢")
		    }
		    if (event.shiftKey) {
		        event.keyCode = 0;
		        event.returnValue = false;
		        alert("惟仪涵提醒你:当前设置不允许使用shift键哦,强制使用会我很伤心呢")
		    }
		    if (event.keyCode == 8) {
		        event.keyCode = 0;
		        event.returnValue = false;
		        alert("惟仪涵提醒你:当前设置不允许使用退格键,强制使用会我很伤心呢")
		    }
		    if (event.keyCode == 13) {
		        event.keyCode = 0;
		        event.returnValue = false;
		        alert("惟仪涵提醒你:当前设置不允许使用回车键,强制使用会我很伤心呢")
		    }
		    if (event.keyCode == 116) {
		        event.keyCode = 0;
		        event.returnValue = false;
		        alert("惟仪涵提醒你:当前设置不允许使用F5刷新键,强制使用会我很伤心呢")
		    }
		    if ((event.altKey) && ((window.event.keyCode == 37) || (window.event.keyCode == 39))) {
		        event.returnValue = false;
		        alert("惟仪涵提醒你:当前设置不允许使用Alt+方向键←或方向键→,强制使用会我很伤心呢")
		    }
		    if ((event.ctrlKey) && (event.keyCode == 78)) {
		        event.returnValue = false;
		        alert("惟仪涵提醒你:当前设置不允许使用Ctrl+N新建IE窗口，,强制使用会我很伤心呢")
		    }
		    if ((event.ctrlKey) && (event.keyCode == 85)) {
		        event.returnValue = false;
		        alert("惟仪涵提醒你:当前设置不允许使用ctrl+U组合键，,强制使用会我很伤心呢")
		    }
		    if ((event.shiftKey) && (event.keyCode == 121)) {
		        event.returnValue = false;
		        alert("惟仪涵提醒你:当前设置不允许使用shift+F10,强制使用会我很伤心呢")
		    }
		}
		
		function rightKey() {
		    if (event.button == 2) {
		        event.returnValue = false;
		        alert("惟仪涵提醒你:当前设置不允许使用鼠标右键,强制使用会我很伤心呢")
		    }
		}
		document.onmousedown = rightKey;
		document.onkeydown = function() {
		    if (window.event && window.event.keyCode == 123) {
		        alert("惟仪涵提醒你:当前设置不允许使用F12,强制使用会我很伤心呢");
		        event.keyCode = 0;
		        event.returnValue = false
		    }
		    if (window.event && window.event.keyCode == 13) {
		        window.event.keyCode = 505
		    }
		    if (window.event && window.event.keyCode == 8) {
		        alert(str + "\n请使用Del键进行字符的删除操作,强制使用会我很伤心呢");
		        window.event.returnValue = false
		    }
		}
		var a_idx = 0;
		var b_idx = 0;
		var a = new Array("自由", "和谐", "平等", "法制", "爱国", "敬业", "公平", "和平", "进步", "友爱", "友善", "共进");
		var b = new Array("#FF0000", "#66CCFF", " #FFFF00", "#00FF00", "#66CCFF", "#0000FF", "#8B00FF", "#FF0000", "#FF7F00", " #FFFF00", "#00FF00", "#00FFFF", "#0000FF", "#8B00FF");
		jQuery(document).ready(function($) {
		    $("body").click(function(e) {
		        var i = $("<span/>").text(a[a_idx]);
		        a_idx = parseInt(12 * Math.random());
		        b_idx = parseInt(14 * Math.random());
		        var x = e.pageX,
		            y = e.pageY;
		        i.css({
		            "z-index": 999,
		            "font-size": "1.3em",
		            "top": y - 20,
		            "left": x,
		            "position": "absolute",
		            "font-weight": "bold",
		            "color": b[b_idx]
		        });
		        $("body").append(i);
		        i.animate({
		            "top": y - 180,
		            "opacity": 0
		        }, 1500, function() {
		            i.remove()
		        })
		    })
		});
	