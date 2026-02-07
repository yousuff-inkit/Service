<html>
<% String contextPath=request.getContextPath();%>
<head>

<%-- <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" /> --%>
<link href="<%=contextPath%>/css/jqx.base.css" rel="stylesheet"  type="text/css" />
<link href="<%=contextPath%>/css/table.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/myButton.css" media="screen" rel="stylesheet" type="text/css" /> 
<link href="<%=contextPath%>/css/jqx.mobile.css" media="screen" rel="stylesheet" type="text/css" /> 
<link href="<%=contextPath%>/css/jqx.energyblue.css" media="screen" rel="stylesheet" type="text/css" />  
    <script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/jqxcore.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/demos.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxdatetimeinput.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxcalendar.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxmenu.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxtabs.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxbuttons.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxscrollbar.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.selection.js"></script> 
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.columnsresize.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.edit.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.sort.js"></script> 
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.pager.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.filter.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.grouping.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxdata.js"></script> 
    <script type="text/javascript" src="<%=contextPath%>/js/globalize.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxpanel.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxlistbox.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxcheckbox.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxtooltip.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/globalize.js"></script>  
	<script type="text/javascript" src="<%=contextPath%>/js/jqxwindow.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqxtree.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.aggregates.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqxexpander.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jquery.easyui.min.js"></script>
	
	<script type="text/javascript" src="<%=contextPath%>/js/jqxdatatable.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqxtreegrid.js"></script>
	
	<%-- <script type="text/javascript" src="<%=contextPath%>/js/alert/jquery-1.4.4.min.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/alert/jquery.easyui.min.js"></script>--%>
	
	<script type="text/javascript" src="<%=contextPath%>/js/jqxchart.core.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxdraw.js"></script>
	<%--<script type="text/javascript" src="<%=contextPath%>/js/jqxslider.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxradiobutton.js"></script> --%>
	
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/icon.css">
  	
  	<script type="text/javascript" src="<%=contextPath%>/js/additional-methods.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery.validate.min.js"></script>
	
	<script type="text/javascript" src="<%=contextPath%>/js/pace.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxdata.export.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.export.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/jqxinput.js"></script>    
	<script type="text/javascript" src="<%=contextPath%>/js/exportExcel.js"></script>
	
		<script type="text/javascript">
function getformbranch(){
	var branchval='<%=session.getAttribute("BRANCHID")%>';
	if(branchval!=null && branchval!='a'){
		window.parent.branchid.value=branchval;	
	}       
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText.trim();
		 	if(parseInt(items)==0)
	 		{
	 		 
	 		
	 		// $.messager.alert('Message','Your Secure Session Has Expired ,Please Login Again.....!','warning');
	 		$.messager.confirm('Confirm', 'Your Secure Session Has Expired ,Please Login Again.....!', function(r){
				if (r){
					window.parent.location.href=<%=contextPath+"/"%>+"login.jsp";
				}
			});
	 		
	 		
	 		 /* window.history.back(); */
	 		 				 		 
	 		Exit();
	 		return 0;
	 		}
     }
	}
      x.open("GET", "<%=contextPath%>/com/dashboard/sessionset.jsp?sessionbrch="+branchval,true);
     x.send();
     
   } 
function funDateInPeriod(value){
	//changed due to - date in string date format and not getting proper date (invalid date)
    //var styear = new Date(window.parent.txtaccountperiodfrom.value);
    //var edyear = new Date(window.parent.txtaccountperiodto.value);
    var stdate = window.parent.txtaccountperiodfrom.value;
	var enddate = window.parent.txtaccountperiodto.value;
	stdate = stdate.split('-');
	enddate = enddate.split('-');
	var st1 = stdate[2].toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false})+"-"+(stdate[1]).toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false})+"-"+stdate[0].toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false});
	var ed1 = enddate[2].toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false})+"-"+(enddate[1]).toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false})+"-"+enddate[0].toLocaleString('en-US', {minimumIntegerDigits: 2, useGrouping:false});    
	var styear = new Date(st1);
	var edyear = new Date(ed1);    
	var mclose = new Date(window.parent.monthclosed.value);
	mclose.setHours(0,0,0,0);
    edyear.setHours(0,0,0,0);
    styear.setHours(0,0,0,0);
    var currentDate = new Date(new Date());
    if(value<styear || value>edyear){
    	$.messager.alert('Warning',"Transaction prior or after Account Period is not valid.");
     $('#txtvalidation').val(1);
     return 0;
    }
     if(value>currentDate){
    	 $.messager.alert('Warning',"Future Date, Transaction Restricted. ");
     $('#txtvalidation').val(1);
     return 0;
    } 
    if(value<=mclose){
    	$.messager.alert('Warning',"Closing Done, Transaction Restricted. ");
     	$('#txtvalidation').val(1);
     	return 0;
    }
    //var tempdtype=document.getElementById("lbldetailname").innerText;
   // console.log("tempdtype"+tempdtype); 
    var taxDate=new Date(window.parent.taxdateval.value);
    taxDate.setHours(0,0,0,0);
    /*if(tempdtype=='Invoice Processing'){
    	if(value<=taxDate){
    		$.messager.alert('Warning',"Tax Closing Done, Transaction Restricted. ");
	        $('#txtvalidation').val(1);
	        return 0;
	       }
 	   }*/
    
    
    $('#txtvalidation').val(0);
     return 1;
 }
 
function funMclose(value){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			items=items.split('####'); 	
			console.log("items==="+items);
			if(items!='null'){
				
				window.parent.monthclosed.value=items[0];
				window.parent.taxdateval.value=items[1];
			}
			else{
				window.parent.monthclosed.value=window.parent.txtaccountperiodfrom.value;	
			}

		} else {
			//alert("Error");
		}
	}
	x.open("GET","<%=contextPath%>/com/dashboard/getMclose.jsp?branch="+value, true);
	x.send();
}
 
</script> 
</head> 
<body onclick="getformbranch();">   
</body>
</html>
