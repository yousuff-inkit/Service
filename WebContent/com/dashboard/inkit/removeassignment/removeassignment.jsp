<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<style type="text/css">
 
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.bicon {
    background-color: #ECF8E0;
	width: 1em;
	height: 1em;
	border: none;
}

</style>

<script type="text/javascript">

$(document).ready(function() {
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

    $('#areainfowindow').jqxWindow({
        width: '25%',
        height: '70%',
        maxHeight: '85%',
        maxWidth: '80%',
        title: ' Area Search',
        position: {
            x: 250,
            y: 60
        },
        keyboardCloseKey: 27
    });
    $('#areainfowindow').jqxWindow('close');

    $('#clientsearch1').jqxWindow({
        width: '50%',
        height: '55%',
        maxHeight: '85%',
        maxWidth: '80%',
        title: 'Client Search',
        position: {
            x: 250,
            y: 120
        },
        keyboardCloseKey: 27
    });
    $('#clientsearch1').jqxWindow('close');

    $("#fromdate").jqxDateTimeInput({
        width: '125px',
        height: '15px',
        formatString: "dd.MM.yyyy"
    });

    $("#todate").jqxDateTimeInput({
        width: '125px',
        height: '15px',
        formatString: "dd.MM.yyyy"
    });

    $("#adate").jqxDateTimeInput({
        width: '100px',
        height: '15px',
        formatString: "dd.MM.yyyy",
        enableBrowserBoundsDetection: true
    });
    $("#atime").jqxDateTimeInput({
        width: '45px',
        height: '15px',
        formatString: "HH:mm",
        showCalendarButton: false
    });
    var todates = new Date($('#todate').jqxDateTimeInput('getDate'));
    var onemounth = new Date(new Date(todates).setMonth(todates.getMonth() - 1));
    $('#todate').jqxDateTimeInput('setDate', new Date());
    $('#adate').jqxDateTimeInput('setDate', new Date());
    $('#atime').jqxDateTimeInput('setDate', new Date());

    $('#txtclient').dblclick(function() {
        $('#clientsearch1').jqxWindow('open');
        clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));
    });

    $('#txtassignarea').dblclick(function() {
        $('#areainfowindow').jqxWindow('open');
        areaSearchContent('area.jsp');
    });
});

function getclinfo(event) {
    var x = event.keyCode;
    if (x == 114) {
        $('#clientsearch1').jqxWindow('open');
        clientSearchContent('clientINgridsearch.jsp?', $('#clientsearch1'));
    } 
}

function clientSearchContent(url) {
    $.get(url).done(function(data) {
        $('#clientsearch1').jqxWindow('setContent', data);
    });
}

function getareas(event) {
    var x = event.keyCode;
    if (x == 114) {
        $('#areainfowindow').jqxWindow('open');
        areaSearchContent('area.jsp');
    }
}

function areaSearchContent(url) {
    $.get(url).done(function(data) {
        $('#areainfowindow').jqxWindow('setContent', data);
    });
}

function funExportBtn() {
    $("#serschedulediv").excelexportjs({
        containerid: "serschedulediv",
        datatype: 'json',
        dataset: null,
        gridId: "jqxloaddataGrid",
        columns: getColumns("jqxloaddataGrid"),
        worksheetName: "Remove Assignment"
    });
}

function funreload() {
    var date = $('#todate').val();
    var barchval = document.getElementById("cmbbranch").value;
    var clientid = $('#clientid').val();
    var area = document.getElementById("txtareaid").value;
    var chkfromdate = $('#hidchckfromdate').val();
    var fromdate = $('#fromdate').val();
	var id = 1;

    $("#jqxloaddataGrid").jqxGrid('clear');
    $("#jqxSerCount").jqxGrid('clear');

    $("#serCountgrid").load("serCountgrid.jsp?date="+date+"&barchval="+barchval+"&clientid="+clientid+"&area="+area+"&id="+id+'&chkfromdate='+chkfromdate+'&fromdate='+fromdate);
}

function funClear() {
    $("#jqxloaddataGrid").jqxGrid('clear');
    $("#jqxSerCount").jqxGrid('clear');

    document.getElementById("txtclient").value = "";
    document.getElementById("clientid").value = "0";

    document.getElementById("txtassignarea").value = "";
    document.getElementById("txtareaid").value = "0";

    $("#txtclient").attr("placeholder", "press F3 for Search");
    $("#txtassignarea").attr("placeholder", "press F3 for Search");
}

function removeAssignment() {
    var pdate = $('#adate').val();
    var ptime = $('#atime').val();

    var selectedrows=$("#jqxloaddataGrid").jqxGrid('selectedrowindexes');
	selectedrows = selectedrows.sort(function(a,b){return a - b});

	if(selectedrows.length==0){
		$.messager.alert('Warning','Select documents.');
		return false;
	}
	
	var gridarray=new Array();   
	
	for (i = 0; i < selectedrows.length; i++) {
		
		var dtype = $('#jqxloaddataGrid').jqxGrid('getcellvalue',selectedrows[i],'dtype');
		var refdocno = $('#jqxloaddataGrid').jqxGrid('getcellvalue',selectedrows[i],'refdocno');
		var empid = $('#jqxloaddataGrid').jqxGrid('getcellvalue',selectedrows[i],'empid');
		var dbname = $('#jqxloaddataGrid').jqxGrid('getcellvalue',selectedrows[i],'dbname');
		var brhid = $('#jqxloaddataGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid');
		
		gridarray.push(dtype+"::"+refdocno+"::"+empid+"::"+dbname+"::"+brhid);
	}     
	
	$.messager.confirm('Message', 'Do you want to Remove Assignment?', function(r){  
		if(r==false) {
			return false; 
		}else{
			removeEmployee(gridarray,pdate,ptime);
		}
	});
}

function removeEmployee(gridarray,pdate,ptime){
	 var x = new XMLHttpRequest();
	    x.onreadystatechange = function() {
	        if (x.readyState == 4 && x.status == 200) {
	        	 var items = x.responseText;
	             items = items.split('###');
	             var res = items[0];

	             if (res > 0) {
	                $.messager.alert('Message', "Assignments Removed");

	                $('#adate').jqxDateTimeInput('setDate', new Date());
	                $('#atime').jqxDateTimeInput('setDate', new Date());

	                funreload();
	            } else {
	                $.messager.alert('Message', "Not Updated");
	            }

	        }
	    }
	    x.open("GET", "removeEmployee.jsp?gridarray=" + gridarray + "&pdate=" + pdate + "&ptime=" + ptime, true);
	    x.send();
}

function fromdatecheck() {
    if (document.getElementById("chckfromdate").checked) {
        document.getElementById("hidchckfromdate").value = 1;
        $('#fromdate').jqxDateTimeInput({
            disabled: false
        });
    } else {
        document.getElementById("hidchckfromdate").value = 0;
        $('#fromdate').jqxDateTimeInput({
            disabled: true
        });
    }
}

</script>

</head>

<body onload="getBranch();fromdatecheck();">
   <div id="mainBG" class="homeContent" data-type="background">
      <div class='hidden-scrollbar'>
         <table width="100%" height="100%" >
            <tr>
               <td width="20%" style=" vertical-align: top;">
                  <fieldset style="background: #ECF8E0;">
                     <table width="100%" >
                        <jsp:include page="../../heading.jsp"></jsp:include>
                        <tr>
                           <td align="right">
                              <input type="checkbox" id="chckfromdate" name="chckfromdate" value="" onchange="fromdatecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" /> 
                              <input type="hidden" id="hidchckfromdate" name="hidchckfromdate" value='<s:property value="hidchckfromdate"/>'/>
                              <label class="branch">From</label>
                           </td>
                           <td align="left">
                              <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                           </td>
                        </tr>
                        <tr>
                           <td width="27%"  align="right" ><label class="branch">Upto</label></td>
                           <td width="73%" align="left">
                              <div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                           </td>
                        </tr>
                        <tr>
                           <td align="right"><label class="branch">Client</label></td>
                           <td ><input style="height:19px;" type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onKeyDown="getclinfo(event);" readonly placeholder="Press F3 to Search">
                              <input type="hidden" id="clientid" name="clientid" value='<s:property value="clientid"/>'>
                              <button type="button" class="bicon" id="clear" title="clear" onclick="funClear()"> 
                              <img alt="clear" src="<%=contextPath%>/icons/clear.png">
                              </button>
                           </td>
                        </tr>
                        </tr>
                        <tr>
                           <td align="right"><label class="branch"> Area</label></td>
                           <td ><input style="height:19px;" type="text" name="txtassignarea" id="txtassignarea" value='<s:property value="txtassignarea"/>' onKeyDown="getareas(event);" readonly placeholder="Press F3 to Search">
                              <input type="hidden" id="txtareaid" name="txtareaid" value='<s:property value="txtareaid"/>'>
                           </td>
                        </tr>
                        <tr>
                           <td colspan="2" >
                              <div id="serCountgrid">
                                 <jsp:include page="serCountgrid.jsp"></jsp:include>
                              </div>
                           </td>
                        </tr>
                        <tr>
                           <td colspan="2" align="center">
                              <label id="test"  class="branch" style="font-family: comic sans ms;font-weight: bold;color:blue;"></label>
                           </td>
                        </tr>
                     </table>
                     <table>
                     <tr><td colspan="2">&nbsp;</td></tr>
                        <tr>
                           <td align="right" ><label class="branch">Date & Time</label></td>
                           <td width="37%"  >
                              <div  id='adate' name='adate' value='<s:property value="adate"/>' ></div>
                           <td width="36%">
                              <div id='atime' name='atime' value='<s:property value="atime"/>' ></div>
                              <input style="height:19px;" type="hidden" name="txtptime" id="txtptime" value='<s:property value="txtptime"/>'  readonly >
                           </td>
                           </td>
                        </tr>
                        <tr>
                           <td></td>
                           <td colspan="2" align="left"><input type="button" name="btnremove" class="myButton"
                              value="Remove Assignment" onclick="removeAssignment();" />
                           </td>
                        </tr>
                     </table>
                     <table>
                        <tr>
                           <td>
                              <input type="hidden" id="isprior" name="isprior" value='<s:property value="isprior"/>'>
                           </td>
                        </tr>
                     </table>
                  </fieldset>
               </td>
               <td width="80" style=" vertical-align: top;">
                  <table width="100%"  >
                     <tr>
                        <td>
                           <div id="serschedulediv">
                              <jsp:include page="serScheduleDetails.jsp"></jsp:include>
                           </div>
                           <br/>
                        </td>
                     </tr>
                  </table>
               </td>
            </tr>
         </table>
      </div>
      <div id="clientsearch1">
         <div ></div>
      </div>
      <div id="areainfowindow">
         <div ></div>
      </div>
   </div>
</body>
</html>