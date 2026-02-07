<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();
//System.out.println("==contextPath===="+contextPath);
//System.out.println("session  value"+session.getMaxInactiveInterval());


String userfrmid=request.getParameter("userfrmid").toString().trim();
 String username=request.getParameter("username").toString().trim();
 String compname=request.getParameter("compname").toString().trim();
//System.out.println("===11111===userfrmid=username=compname="+userfrmid+" "+username+" "+compname+"");


%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	 getToUserID();
	 getFrmUserID();
	    $('#onlineDiv').hide();
		$('#awayDiv').hide();
		
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src=<%=contextPath+'/'%>icons/31load.gif></div>");
	     
	     
	 element = document.getElementById('mainBG');
	 element.addEventListener("mouseover",function(){
		 useronline();
	    
	 });
	 setTimeout(function() {
		 getMsgHistory();
		 useronline();
		}, 2000);
	
});

</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

<style type="text/css">
#icono {
 width: 2.5em;
 height: 2em;
 border: none;
 float: right;
 background-color: #E0ECF8;
}

#icona {
 width: 2.5em;
 height: 2em;
 border: none;
 float: right;
 background-color: #E0ECF8;
}

</style>

<script type="text/javascript">

function getToUserID()
{


var x=new XMLHttpRequest();
var msgcnt;
var user;
x.onreadystatechange=function(){
	
	if (x.readyState==4 && x.status==200)
		{
		
			items= x.responseText;
		
			items=items.split('####');
			user=items[0];
			userid=items[1];
			document.getElementById("usertoid").value=userid.trim();
			
		}
	else
		{
		}
}
x.open("GET","getSupportcenterId.jsp",true);
x.send();
}


function useronline()
{

var userfrmid=document.getElementById("userfrmid").value;
var usertoid=document.getElementById("usertoid").value;

	
var x=new XMLHttpRequest();
var msgcnt;
var user;
x.onreadystatechange=function(){
	
	if (x.readyState==4 && x.status==200)
		{
		
	 		items= x.responseText;
		
			document.getElementById("isonline").value=items.trim(); 
			
			if(items.trim()==0){
				
				/* $.messager.show({title:'Message',msg:'GateWay SupportCenter is Offline,You can leave a message to them!!!',showType:'show',
                    style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                }); 
				 */
				$('#onlineDiv').hide();
				$('#awayDiv').show();
				
			}
			else{
				
				/* $.messager.show({title:'Message',msg:'GateWay SupportCenter is Online',showType:'show',
                    style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                }); */
				
				$('#onlineDiv').show();
				$('#awayDiv').hide();
				
			}
			
		}
	else
		{
		}
}
x.open("GET",'useronline.jsp?userfrmid='+userfrmid+'&usertoid='+usertoid,true);
x.send();
}

function useroffline()
{

var userfrmid=document.getElementById("userfrmid").value;
var usertoid=document.getElementById("usertoid").value;

	
var x=new XMLHttpRequest();
var msgcnt;
var user;
x.onreadystatechange=function(){
	
	if (x.readyState==4 && x.status==200)
		{
		
			items= x.responseText;
		
			/* items=items.split('####');
			user=items[0];
			userid=items[1];*/
			document.getElementById("isonline").value=items.trim();
			
			
			
		}
	else
		{
		}
}
x.open("GET",'useroffline.jsp?userfrmid='+userfrmid+'&usertoid='+usertoid,true);
x.send();
}


function getFrmUserID()
{


	<%-- var userfrmid='<%=request.getParameter("userfrmid").toString().trim()%>'; --%>
	var username='<%=request.getParameter("username").toString().trim()%>';
	var compname='<%=request.getParameter("compname").toString().trim()%>';

var x=new XMLHttpRequest();
var msgcnt;
var user;
var compcode;
x.onreadystatechange=function(){
	
	if (x.readyState==4 && x.status==200)
		{
		
			items= x.responseText;
		
			items=items.split('####');
			user=items[0];
			userid=items[1];
			compcode=items[2];
			document.getElementById("userfrmid").value=userid;
			document.getElementById("userfrmnm").value=user;
			document.getElementById("compcode").value=compcode.trim();
			
		}
	else
		{
		}
}
x.open("GET","getFrmuserId.jsp?username="+username+"&compname="+compname,true);
x.send();
}

 window.setInterval(function(){
	getMsgHistory();
}, 2000);

  window.setInterval(function(){
	  useroffline();
}, 1200000);
  
 

function sendMsg(){

	//var user=document.getElementById("txtuser").value;
	var usertoid=document.getElementById("usertoid").value;
	var userfrmid=document.getElementById("userfrmid").value;
	var msg=document.getElementById("txtmsgenter").value;


	if(usertoid==""){
		$.messager.alert('Message',"Select a User to Text");
		return 0;
	}

	if(msg==""){
		$.messager.alert('Message',"type message to send");
		return 0;
	}

	//alert(date);
	  var x = new XMLHttpRequest();
	  x.onreadystatechange = function() {
	   if (x.readyState == 4 && x.status == 200) {
	    var item=x.responseText.trim();
	    
	    if(item>0)
		{
		//document.getElementById("waringmsg").innerText="Send Successfully";
		getMsgHistory();
		document.getElementById("txtmsgenter").value="";
		
			return  true;
		}

	else
	 {

	$.messager.alert('Message',"Failed");
	return  false;
	 }
	    
	   } else {
	   }
	  }
	  x.open("POST","msginsert.jsp?usertoid="+usertoid+"&userfrmid="+userfrmid+"&msg="+msg, true);
	  x.send();  
	 }
	 
function getMsgHistory(){
	
	var usertoid=document.getElementById("usertoid").value.trim();
	var userfrmid=document.getElementById("userfrmid").value.trim();
	var msg=document.getElementById("txtmsgenter").value.trim();
	
	$('#supportHistoryGrid').load('supportCenterFormGrid.jsp?userfrmid='+userfrmid+'&usertoid='+usertoid);
	
			//$('#newdiv').load('newgrid.jsp?fleet='+document.getElementById("rfleet").value+'&doc='+document.getElementById("docno").value+'&code='+document.getElementById("formdetailcode").value);
	
}


function sendMsgenter(event){

	//var user=document.getElementById("txtuser").value;
	var usertoid=document.getElementById("usertoid").value;
	var userfrmid=document.getElementById("userfrmid").value;
	var msg=document.getElementById("txtmsgenter").value;
   
	var x= event.keyCode;
	
	if(x==13){
   
	if(usertoid==""){
		$.messager.alert('Message',"Select a User to Text");
		return 0;
	}

	if(msg==""){
		$.messager.alert('Message',"type message to send");
		return 0;
	}

	//alert(date);
	  var x = new XMLHttpRequest();
	  x.onreadystatechange = function() {
	   if (x.readyState == 4 && x.status == 200) {
	    var item=x.responseText.trim();
	    
	    if(item>0)
		{
		//document.getElementById("waringmsg").innerText="Send Successfully";
		getMsgHistory();
		document.getElementById("txtmsgenter").value="";
		
			return  true;
		}

	else
	 {

	$.messager.alert('Message',"Failed");
	return  false;
	 }
	    
	   } else {
	   }
	  }
	  x.open("GET","msginsert.jsp?usertoid="+usertoid+"&userfrmid="+userfrmid+"&msg="+msg, true);
	  x.send();
	}
	 }



function ajaxFileUpload()  
{  

	var d = new Date();
    var n = d.getDate();
    var p = d.getMonth();
 
      var dates=n+"-"+p;
      var usertoid=document.getElementById("usertoid").value.trim();
  	  var userfrmid=document.getElementById("userfrmid").value.trim();
  	var compcode=document.getElementById("compcode").value.trim();
	    //check whether browser fully supports all File API
	    if (window.File && window.FileReader && window.FileList && window.Blob)
	    {
	        //get the file size and file type from file input field
	        var fsize = $('#file')[0].files[0].size;
	        
	        if(fsize>1048576) //do something if file size more than 1 mb (1048576)
	        {
	            //$.messager.alert('Message',fsize +' bites\nToo big!','warning');
	            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                  style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
              }); 
	            return;
	        }
	    }else{
	    	//$.messager.alert('Message','Please upgrade your browser, because your current browser lacks some new features we need!','warning');
	    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
                      style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                  }); 
	        return;
	    }
	
    $.ajaxFileUpload  
    (  
        {  
            url:'supportAttachAction.action?compname='+compcode+'&date='+dates+'&userfrmid='+userfrmid+'&usertoid='+usertoid,
            secureuri:false,//false  
            fileElementId:'file',//id  <input type="file" id="file" name="file" />  
            dataType: 'json',// json  
            success: function (data, status)  //  
            {  
                //alert(data.message);//jsonmessage,messagestruts2
           	
         //       $('#refreshdiv').load();
                <%-- var data='<%= com.common.ClsAttach.reload(docNo) %>';
                alert("============="+data); --%>
               if(status=='success'){
               	$("#overlay, #PleaseWait").hide();
            	   getMsgHistory();
                   $.messager.show({title:'Message',msg:' Send Successfully',showType:'show',
                      style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                  });
                   
                }
               
                $("#testImg").attr("src",data.message);
                if(typeof(data.error) != 'undefined')  
                {  
                    if(data.error != '')  
                    {  
                        //$.messager.alert('Message',data.error);
                        $.messager.show({title:'Message',msg: data.error,showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                    }else  
                    {  
                        //$.messager.alert('Message',data.message);
                        $.messager.show({title:'Message',msg: data.message,showType:'show',
	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	                        }); 
                    }  
                }  
            },  
            error: function (data, status, e)//  
            {  
                //alert(e);  
                $.messager.alert('Message',e);
            }  
        }  
    )  
    return false;  
}

function reload(){
$("#jqxDocumentsAttach").jqxGrid('updatebounddata', 'sort');

<%--  $('#jqxDocumentsAttach').jqxGrid('refreshdata');
//Thread.sleep(10000);
$("#jqxDocumentsAttach").jqxGrid('addrow', null, <%= com.common.ClsAttach.reload(docNo)%>);
$("#jqxDocumentsAttach").jqxGrid('addrow', null, <%= com.common.ClsAttach.reload(docNo)%>); --%>
}

function SaveToDisk(fileURL, fileName) {
//alert(fileURL);
//fileName='';
var host = window.location.origin;
//alert("hooosssst"+host);

var splt = fileURL.split("webapps"); 

//alert("after split"+splt[1]);
var repl = splt[1].replace( /;/g, "/");
//alert("repl"+repl);
fileURL=host+"/"+repl;
//alert("fileURL===="+fileURL);
// for non-IE
if (!window.ActiveXObject) {
  var save = document.createElement('a');
  //alert(save);
  //alert(fileURL);
  save.href = fileURL;
  save.target = '_blank';
  save.download = fileName || 'unknown';
	
  window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
  
  //var event = document.createEvent('Event');
 // alert(event);
  //event.initEvent('click', true, true);
  //save.dispatchEvent(event);
  //(window.URL || window.webkitURL).revokeObjectURL(save.href);
}

// for IE
else if ( !! window.ActiveXObject && document.execCommand)     {
  var _window = window.open(fileURL, '_blank');
  _window.document.close();
  _window.document.execCommand('SaveAs', true, fileName || fileURL)
  _window.close();
}
}

function Delete(){
var filename=document.getElementById("filename").value;
/* var spltname = filename.split(".");
alert("==spltname==="+spltname[0]); */
<%-- alert("==filename=="+filename);
var dtype=<%=request.getParameter("formCode")%>;
alert("==dtype=="+dtype);
var doc_no=<%=request.getParameter("docno")%>;
--%>

//alert("==doc_no=="+doc_no);
var x=new XMLHttpRequest();
var items,brchItems,currItems,mcloseItems;
x.onreadystatechange=function(){
if (x.readyState==4 && x.status==200)
{
   items= x.responseText;
   if(items>0){
  	 
  	 //$.messager.alert('Message','Successfully Deleted');
  	 $.messager.show({title:'Message',msg:'Successfully Deleted',showType:'show',
           style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
       }); 
   }
   else{
	  //$.messager.alert('Message','Not Deleted');
	 $.messager.show({title:'Message',msg:'Not Deleted',showType:'show',
       style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
   }); 
     }
}
else
{}
}
x.open("GET",<%=contextPath+"/"%>+"fileAttachDelete.jsp?filename="+filename,true);
x.send();
}

function saveViaAJAX()
{

	var d = new Date();
    var n = d.getDate();
    var p = d.getMonth();
    
      var dates=n+"-"+p;
      var usertoid=document.getElementById("usertoid").value.trim();
  	  var userfrmid=document.getElementById("userfrmid").value.trim();
	  var formname=document.getElementById("compcode").value.trim();


var testCanvas = document.getElementById("canvasid");  
	var canvasData = testCanvas.toDataURL("image/png");
	
	var postData = "canvasData="+canvasData;
//var canvasData = testCanvas.toDataURL("image/png");


var ajax = new XMLHttpRequest();
ajax.open("POST",'saveImages.jsp?formname='+formname+'&date='+dates+'&usertoid='+usertoid+'&userfrmid='+userfrmid,true);    
ajax.setRequestHeader('Content-Type', 'canvas/upload');

ajax.onreadystatechange=function()
	{
	if (ajax.readyState == 4)
	{ 
		//document.getElementById("savemsg").innerText="Successfully Attached";
		getMsgHistory();
		 $.messager.show({title:'Message',msg:' Send Successfully',showType:'show',
           style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
       });
		  //$.messager.alert('Message',"Successfully Attached");
		 
		//alert(ajax.responseText);
		// Write out the filename.
		
	}
	}

ajax.send(postData);  
}

function upload(){
	$("#overlay, #PleaseWait").show();
var path=document.getElementById("file").value;
var fsize = $('#file')[0].files[0].size;
//alert(fsize);
var extn = path.substring(path.lastIndexOf(".") + 1, path.length);

if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP'))
  {
	 
	 if(fsize>1048576)
		 {
		 setTimeout(function() {
			 saveViaAJAX();
			}, 3000);
		 
		 }
	 else{
		 setTimeout(function() {
			 ajaxFileUpload();
			}, 3000);
		 
      		
      }
	 
	 
  }
  else{
	  setTimeout(function() {
			 ajaxFileUpload();
			}, 3000);
  }

}



function loading(){

var path=document.getElementById("file").value;
var fsize = $('#file')[0].files[0].size;
var extn = path.substring(path.lastIndexOf(".") + 1, path.length);

if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP'))
{

if(fsize>1048576)
	 {
	 //document.getElementById("waringmsg").innerText="Please Wait......";
	 }



}



}


</script>

</head>
<body >
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSupportChat" action="saveSupportChat" method="post" autocomplete="off">

<div  class='hidden-scrollbar'>
<fieldset>
<input type="hidden" id="usertoid" name="usertoid"  value='<s:property value="usertoid"/>'/>
<input type="hidden" id="userfrmid" name="userfrmid"  value='<s:property value="userfrmid"/>'/>
<input type="hidden" id="userfrmnm" name="userfrmnm"  value='<s:property value="userfrmnm"/>'/>
<input type="hidden" id="compcode" name="compcode"  value='<s:property value="compcode"/>'/>
<input type="hidden" id="isonline" name="isonline"  value='<s:property value="isonline"/>'/>

<table width="100%">
  <tr>
     <td height="40" colspan="3" align="center"><img src="<%=contextPath+"/"%>icons/gwsupportcenter.png" style="width: 30%; height:55px;">
     </td>
         <td width="6%"  align="right">
         <div id="onlineDiv">
         <font style="font-family: Verdana;font-weight: bold;font-style: italic;font-size: 15px;color: #32CD32;">Available</font>
         <button id="icono"  title="Online" type="button">
   <img alt="Online" src="<%=contextPath+"/"%>icons/online.png">
  </button>
  </div>
  <div id="awayDiv" >
  <font style="font-family: Verdana;font-weight: bold;font-style: italic;font-size: 15px;color: #FFBF00;">Away</font>
  <button id="icona"  title="Away" type="button">
   <img alt="Away" src="<%=contextPath+"/"%>icons/away.png">
  </button>
  </div>
  </td>
  </tr>
  <tr>
    <td colspan="4"><div id="supportHistoryGrid"><jsp:include page="supportCenterFormGrid.jsp"></jsp:include></div></td>
  </tr>
  <tr>
    <td colspan="4"><textarea id="txtmsgenter" style="height:65px;width:99.5%;font: 10px Tahoma;resize:none"  placeholder="Enter message..." name="txtmsgenter" onkeydown="sendMsgenter(event);"><s:property value="txtmsgenter" ></s:property></textarea></td>
  </tr>
  
  <tr>
   
    <td width="50%" align="right"><button class="myButton" type="button" id="btnSend" name="btnSend" onClick="sendMsg()">Send</button></td>
    <td colspan="3" align="left">&nbsp;&nbsp;<input type="file" id="file" name="file" onChange="return upload();" /></td>

  </tr>
</table>
<input id="width" type="hidden" value="640" />
<input id="height" type="hidden" />
<input id="data" type="hidden" />
<br /><span id="message"></span><br />
<canvas id="canvasid"  hidden="true" height="480" width="640"></canvas>
<label id="waringmsg" name="waringmsg" style="color:red;font-weight:bold;"></label>
<div id="img"></div>
<input type="hidden" name="filename" id="filename" value='<s:property value="filename"/>'/>
</fieldset>

</div>
</form>
	
</div>
</body>


<script>
	(function ( $width, $height, $file) {
		
		// (C) WebReflection Mit Style License
		
		// simple FileReader detection
		
		
		// async callback, received the
		// base 64 encoded resampled image
		function resampled(data) {
			//$message.innerHTML = "done";
			
		/* 	  ($img.lastChild || $img.appendChild(new Image)
			).src = data; */
			document.getElementById("data").value=data;
			/* var img = document.getElementById('imgid').src;

			alert(img.getAttribute('src')); // foo.jpg
			alert(img.src); */
			
			/* document.getElementById('imgid').src=data; */
			
			var imgid = new Image();
			imgid.src =data;
			
			var temp_paint = $('#canvasid');
			var temp_ctx = temp_paint[0].getContext('2d');
			
			  //var img = document.getElementById('imgid').src;
			$("#overlay, #PleaseWait").hide();
			 //document.getElementById("waringmsg").innerText=" ";
			  temp_ctx.drawImage(imgid, 0, 0,640, 480);
	     
		}
		
		// async callback, fired when the image
		// file has been loaded
		function load(e) {
			//$message.innerHTML = "resampling ...";
			// see resample.js
			Resample(
					this.result,
					this._width || null,
					this._height || null,
					resampled
			);
			
		}
		
		// async callback, fired if the operation
		// is aborted ( for whatever reason )
		function abort(e) {
			//$message.innerHTML = "operation aborted";
		}
		
		// async callback, fired
		// if an error occur (i.e. security)
		function error(e) {
			//$message.innerHTML = "Error: " + (this.result || e);
		}
		
		// listener for the input@file onchange
		$file.addEventListener("change", function change() {
			var
				// retrieve the width in pixel
				width = parseInt($width.value, 10),
				// retrieve the height in pixels
				height = parseInt($height.value, 10),
				// temporary variable, different purposes
				file
			;
			// no width and height specified
			// or both are NaN
			if (!width && !height) {
				// reset the input simply swapping it
				$file.parentNode.replaceChild(
					file = $file.cloneNode(false),
					$file
				);
				// remove the listener to avoid leaks, if any
				$file.removeEventListener("change", change, false);
				// reassign the $file DOM pointer
				// with the new input text and
				// add the change listener
				($file = file).addEventListener("change", change, false);
				// notify user there was something wrong
				//$message.innerHTML = "please specify width or height";
			} else if(
				// there is a files property
				// and this has a length greater than 0
				($file.files || []).length &&
				// the first file in this list 
				// has an image type, hopefully
				// compatible with canvas and drawImage
				// not strictly filtered in this example
				/^image\//.test((file = $file.files[0]).type)
			) {
				// reading action notification
				//$message.innerHTML = "reading ...";
				// create a new object
				file = new FileReader;
				// assign directly events
				// as example, Chrome does not
				// inherit EventTarget yet
				// so addEventListener won't
				// work as expected
				file.onload = load;
				file.onabort = abort;
				file.onerror = error;
				// cheap and easy place to store
				// desired width and/or height
				file._width = width;
				file._height = height;
				// time to read as base 64 encoded
				// data te selected image
				file.readAsDataURL($file.files[0]);
				// it will notify onload when finished
				// An onprogress listener could be added
				// as well, not in this demo tho (I am lazy)
			} else if (file) {
				// if file variable has been created
				// during precedent checks, there is a file
				// but the type is not the expected one
				// wrong file type notification
				//$message.innerHTML = "please chose an image";
			} else {
				// no file selected ... or no files at all
				// there is really nothing to do here ...
				//$message.innerHTML = "nothing to do";
			}
		}, false);
	}(
	
		// all required fields ...
		document.getElementById("width"),
		document.getElementById("height"),
		document.getElementById("file")
	));
	</script>



</html>
