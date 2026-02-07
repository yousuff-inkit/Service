<%@page import="com.dashboard.skips.dispatch.ClsDispatchDAO"%>
<%   
ClsDispatchDAO sd=new ClsDispatchDAO();                   
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
   
 <%
     String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();
 %>      
<script type="text/javascript">    
var unddata;
var dataexcel;
 var flchk='<%=check%>';   
    
	if(flchk!='0'){ 
		<%--   unddata='<%=sd.underwriterGrid(check) %>';            
		  dataexcel='<%=sd.underwriterExcel(check) %>';            --%>
	}      
	else{   
		
	}
$(document).ready(function(){           
    
    var source =
    {             
            datatype: "json",
            datafields: [
                        {name : 'cnttrno',type:'string'},
                        {name : 'tr_no' , type: 'number'},
                      	{name : 'type' , type: 'string'},           
 						{name : 'estatus', type: 'string'},
 						{name : 'lstdate', type:'date'},             
 						{name : 'lstuser',type:'string'},
                      	{name : 'enqno', type: 'number'  },
                      	{name : 'enqdate',type:'date'},
                      	{name : 'age',type:'number'},
                       	{name : 'refname',type:'string'},
                      	{name : 'area',type:'string'},
                      	{name : 'sertype',type:'string'},
                      	{name : 'instype',type:'string'},
                      	{name : 'qotno',type:'string'},
                      	{name : 'qotdate',type:'string'},
                      	{name : 'telesale',type:'string'},
                      	{name : 'salesman',type:'string'},
                      	{name : 'underwriter',type:'string'},
                      	{name : 'cntno',type:'number'},
                      	{name : 'cntdate',type:'string'},  
                      	{name : 'statusid',type:'string'},
             ],                  
             localdata: unddata,    
              
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#UnderwriterGrid").jqxGrid(
                {
                	width: '100%',
                    height: 500,
                    sortable: true,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [  
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   }, 
						{ text: 'cnttrno',datafield: 'cnttrno', width: '6%',hidden:true},
						{ text: 'statusid',datafield: 'statusid', width: '6%',hidden:true},
						{ text: 'trno',datafield: 'tr_no', width: '6%',hidden:true},           
    					{ text: 'Type',datafield: 'type', width: '6%'},    
    					{ text: 'Status',datafield: 'estatus', width: '9%'},
    					{ text: 'Last Update',datafield: 'lstdate', width: '9%',cellsformat:'dd.MM.yyyy HH:mm:ss'},
    					{ text: 'Last Update User',datafield: 'lstuser', width: '10%'},
    					{ text: 'Enq No',datafield: 'enqno', width: '5%'},
    					{ text: 'Enq Date',datafield:'enqdate',width: '5%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'Client', datafield: 'refname', width: '14%'},         
						{ text: 'Area', datafield: 'area', width: '9%'},       
						{ text: 'Service Type', datafield: 'sertype', width: '10%'},
						{ text: 'Insurance Type', datafield: 'instype', width: '10%'},
						{ text: 'Qot No', datafield: 'qotno', width: '5%'},   
						{ text: 'Qot Date', datafield: 'qotdate', width: '5%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Telesales', datafield: 'telesale', width: '10%'},  
						{ text: 'Salesman', datafield: 'salesman', width: '12%'},  
						{ text: 'Business Processor', datafield: 'underwriter', width: '10%'},
						{ text: 'Contract No', datafield: 'cntno', width: '6%'},
						{ text: 'Contract Date', datafield: 'cntdate', width: '6%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Age', datafield: 'age', width: '6%',cellsalign:'right',align:'right'},                     
				   ]                                              
                });  
                   $("#overlay, #PleaseWait").hide();
                   $('#UnderwriterGrid').on('rowdoubleclick', function (event) {    
                           
                   var rowindex2 = event.args.rowindex; 
                   document.getElementById("cnttrno").value=$('#UnderwriterGrid').jqxGrid('getcellvalue', rowindex2, "cnttrno");
                   document.getElementById("txtrefname").value=$('#UnderwriterGrid').jqxGrid('getcellvalue', rowindex2, "refname");
                   document.getElementById("txtqotno").value=$('#UnderwriterGrid').jqxGrid('getcellvalue', rowindex2, "qotno");
                   document.getElementById("statusid").value=$('#UnderwriterGrid').jqxGrid('getcellvalue', rowindex2, "statusid");
                   document.getElementById("txttrno").value=$('#UnderwriterGrid').jqxGrid('getcellvalue', rowindex2, "tr_no");
                   document.getElementById("txtenqno").value=$('#UnderwriterGrid').jqxGrid('getcellvalue', rowindex2, "enqno");
                   document.getElementById("txtenqdate").value=$('#UnderwriterGrid').jqxGrid('getcellvalue', rowindex2, "enqdate");
                   $('.textpanel p').text('ENQ No '+$('#UnderwriterGrid').jqxGrid('getcellvalue',rowindex2,'enqno')+' - '+$('#UnderwriterGrid').jqxGrid('getcellvalue', rowindex2, "refname"));
                   $('.comments-container').html(''); 
                   confrmstatus();  
                   });     
	});     
</script>
<div id="UnderwriterGrid"></div>      