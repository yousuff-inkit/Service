
 <%--  <jsp:include page="../../../includes.jsp"></jsp:include> --%>  
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" >

	function getatype(){
       typeSearchContent('atype.jsp'); 
    }
    	 
	function getadress(){
		addressSearchContent('adressed.jsp'); 
  	 }

   function SaveToDisk(fileURL, fileName) {
	   //alert(fileURL);
	   //fileName='';
	   var host = window.location.origin;
	   //alert("hooosssst"+host);
	  
	   var splt = fileURL.split("webapps"); 
	  //alert("after split"+splt[1]);
	   var repl = splt[1].replace( /;/g, "/");
	  // alert("repl"+repl);
	   //alert("after replace===="+repl);
	   fileURL=host+repl;
	   //alert("fileURL===="+fileURL);
	    // for non-IE
	    if (!window.ActiveXObject) {
	        var save = document.createElement('a');
	        //alert(save);
	       // alert(fileURL);
	        save.href = fileURL;
	        save.target = '_blank';
	        save.download = fileName || 'unknown';
	        window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
	        /* var event = document.createEvent('Event');
	       // alert(event);
	        event.initEvent('click', true, true);
	        save.dispatchEvent(event);
	        (window.URL || window.webkitURL).revokeObjectURL(save.href); */
	    }

	    // for IE
	    else if ( !! window.ActiveXObject && document.execCommand)     {
	        var _window = window.open(fileURL, '_blank');
	        _window.document.close();
	        _window.document.execCommand('SaveAs', true, fileName || fileURL)
	        _window.close();
	    }
	}
   
   
   function Delete()
	{
	   var filename=document.getElementById("filename").value;
	   var spltname = filename.split(".");
	   
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
	        	
	 	        referencedetails();
	        }
	       
	        }
		else
			{
			}
	}
	x.open("GET",<%=contextPath+"/"%>+"fileAttachDelete.jsp?filename="+spltname[0],true);
	x.send();
}
   
   


function ajaxFileUpload() 
{  
	//alert("fileAttachAction");
    $.ajaxFileUpload  
    (  
        {  
            url:'fileAttach.action?formCode=<%=request.getParameter("formCode")%>&doc_no=<%=request.getParameter("docno")%>&descpt='+$("#descptn").val()+'&remarks='+$("#remarks").val()+'&typeid='+$("#atypeid").val()+'&addresid='+$("#addresid").val() ,  
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
            	   $.messager.show({title:'Message',msg:'Saved Successfully',showType:'show',
                       style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                   });
                //funAttachBtn();
                //alert("successsuccesssuccess");
            	   <%-- $("#referenceDetailsDiv").load('referenceDetailsGrid.jsp?docno='+<%=request.getParameter("docno")%>+'&formCode='+<%=request.getParameter("formCode")%>); --%>
            	  /*  $('#referenceDetailsDiv').load(); */
            	  referencedetails();
                }
               
                $("#testImg").attr("src",data.message);
                if(typeof(data.error) != 'undefined')  
                {  
                    if(data.error != '')  
                    {  
                        alert(data.error);  
                    }else  
                    {  
                        alert(data.message);  
                    }  
                }  
            },  
            error: function (data, status, e)//  
            {  
                alert(e);  
            }  
        }  
    )  
    return false;  
}

</script>

</head>
<body>
<!-- <form id="frmEnquiryAttach" action="fileAttach" method="post" autocomplete="off"> -->
<fieldset><legend>Reference Details</legend>
<table width="100%">
  <tr>
    <td width="7%" align="right">Description</td>
    <td width="58%"><input type="text" id="descptn" name="descptn" style="width:90%;" value='<s:property value="descptn"/>'/></td>
    <!-- <td width="10%" rowspan="2" align="right">Select</td> -->
    <td align="right"><input type="file" id="file" name="file" /></td>  
    <td width="27%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Attach"  onclick="return ajaxFileUpload();"></td>
    <td width="25%" rowspan="2">&nbsp;</td>
    <td width="27%" align="left"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Delete"  onclick="return Delete();"></td>
    <!-- <td width="25%" rowspan="2">&nbsp;</td> -->
  </tr>
  <tr>
    <td align="right">Remarks</td>
    <td><input type="text" id="remarks" name="remarks" style="width:90%;" value='<s:property value="remarks"/>'/></td>
  </tr>
  <tr>
    <td align="right">Type</td>
    <td colspan="4"><input type="text" id="atype" name="atype" style="width:20%;" placeholder="Press F3 to Search" readonly value='<s:property value="atype"/>' onKeyDown="getatype();" ondoubleclick="getatype();" />&nbsp;&nbsp;
    Addressed&nbsp;&nbsp;<input type="text" id="addres" name="addres" style="width:20%;" placeholder="Press F3 to Search" readonly value='<s:property value="addres"/>' onKeyDown="getadress();" ondoubleclick="getadress();" />
    <input type="hidden" id="atypeid" name="atypeid"  value='<s:property value="atypeid"/>'/>
    <input type="hidden" id="addresid" name="addresid"  value='<s:property value="addresid"/>'/>
    <input type="hidden" id="filename" name="filename"  value='<s:property value="filename"/>'/></td>
    
    </tr>
  </table>
</fieldset><br/>
<!-- </form> -->
 <div id="referenceDetailsDiv"><jsp:include page="referenceDetailsGrid.jsp"></jsp:include></div>

</body>
</html>
