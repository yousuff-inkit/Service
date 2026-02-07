 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
 <% 
 /* int assgnid=request.getParameter("assgnid")==null?0:Integer.parseInt(request.getParameter("assgnid").trim()); */
 int assgnid=0;
 
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").trim());
 %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
		 var assgnid='<%=assgnid%>';
     	   id='<%=id%>';
	}); 

 	function loadFillSearch() {
		getdata(assignid,id);
	}
 	
	function getdata(assignid,id){
		 $("#refreshdiv").load('assignMemberMultiSearchGrid.jsp?assignid='+assignid+'id='+id);
	}
	
	function loadSearchSelect(){
		$('#jqxgrptosearch').jqxGrid('clearfilters');
		
		var rows = $("#jqxgrptosearch").jqxGrid('getrows');
		
		var selectedrows=$("#jqxgrptosearch").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		var i=0;var j=0;var k=0;var tempname="",tempdocno="",tempempid="",tempemp="";
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					if(k==0){
						tempname=rows[i].name;
						tempdocno=rows[i].doc_no;
						tempempid=rows[i].empid;
						tempemp=rows[i].empid+"::"+rows[i].dbname;

					}else{
						tempname=tempname+","+rows[i].name;
						tempdocno=tempdocno+","+rows[i].doc_no;
						tempempid=tempempid+","+rows[i].empid;
						tempemp=tempemp+","+rows[i].empid+"::"+rows[i].dbname;

					}
				k++;	
				j++; 
			  }
            }
	    if(id==1){
		    $('#txtsergrpemp').val(tempname);
		    $('#grpsermemberid').val(tempdocno);
		    $('#grpserempid').val(tempempid);
		    
	    }else if(id==2){
	    	$('#txtgrpmember').val(tempname);
	    	$('#grpmemberid').val(tempdocno);
	    	$('#grpempid').val(tempemp);
	    	
	    }
	   
	    $('#teaminfowindow').jqxWindow('close'); 
	}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td  hidden="true" align="right" style="font-size:9px;">Group code</td>
    <td hidden="true" colspan="2"><input type="text" name="txtfillgrpcode" id="txtfillgrpcode" style="width:100%;height:20px;" value='<s:property value="txtfillgrpcode"/>'></td>
    <td  >
    <input type="button" name="btnsearchselectok" id="btnsearchselectok" class="myButton" value="OK"  onclick="loadSearchSelect();"></td>
  </tr>
  <tr hidden="true">
  <td width="7%" align="right" style="font-size:9px;">ID#</td>
    <td width="26%"><input type="text" name="txtfillempid" id="txtfillempid" style="width:70%;height:20px;" value='<s:property value="txtfillempid"/>'></td>
    <td width="18%" align="right" style="font-size:9px;">Contact No.</td>
    <td width="49%"><input type="text" name="txtfillempname" id="txtfillempname" style="width:50%;height:20px;" value='<s:property value="txtfillempname"/>'></td>   
  </tr>
 
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="assignMemberMultiSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>