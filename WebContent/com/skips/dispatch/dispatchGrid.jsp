<%@page import="com.skips.dispatch.ClsDispatchDAO"%>
<%   
ClsDispatchDAO sd=new ClsDispatchDAO();                   
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
 <%
     String userid=request.getParameter("userid")==null?"0":request.getParameter("userid").toString();
 	 String check=request.getParameter("check")==null?"0":request.getParameter("check").toString();
 	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 	 String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();

 %>                
<script type="text/javascript">          
var pdata;  
var check='<%=check%>';
var fromdate='<%=fromdate%>';
var todate='<%=todate%>';


if(check==1){
	
	pdata='<%=sd.dispatchGrid(userid,check,fromdate,todate) %>';  
	  
}
else{
	pdata;
}
$(document).ready(function(){  

        var source =
        {
            datatype: "json",            
            datafields: [   
                        {name : 'crtuser', type: 'string'},     
                        {name : 'userid', type: 'string'},      
                        {name : 'ass_user', type: 'string'},  
                      	{name : 'doc_no', type: 'string'},
                    	{name : 'client',type:'string'},  
                    	{name : 'address', type: 'string'},
 						{name : 'location', type: 'string'},
 						{name : 'contact',type:'string'},  
 						{name : 'date',type:'date'},
 						{name : 'time',type:'string'},
                      	{name : 'message', type: 'string'},      
                      	{name : 'collectdet',type:'string'}, 
                      	{name : 'dispatchdet',type:'string'},  
                      	{name : 'user',type:'string'}, 
                      	{name : 'status',type:'string'}, 
             ],
             localdata: pdata,
            
            
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



        $("#dispatchGrid").jqxGrid(  
                {
                	width: '100%',
                    height: 370,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlecell',
                    enabletooltips:true,
                  	editable:false,
                    altrows:true,
                     columnsresize: true,
                    //Add row method 
                    columns: [            
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },             
    					{ text: 'Doc No',datafield: 'doc_no', width: '4%'},            
    					{ text: 'Created User',datafield: 'crtuser', width: '7%'},  
    					{ text: 'St.Date',datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'St.Time',datafield: 'time', width: '6%',cellsformat:'dd.MM.yyyy HH:mm:ss'},         
    					{ text: 'Client',datafield: 'client', width: '11%'},  
    					{ text: 'Address',datafield: 'address', width: '8%'},
    					{ text: 'Location',datafield: 'location', width: '8%'}, 
    					{ text: 'Contact',datafield: 'contact', width: '8%'}, 
    					{ text: 'Dispatch details',datafield: 'dispatchdet', width: '7%'}, 
    					{ text: 'Collect details',datafield: 'collectdet', width: '7%'}, 
    					{ text: 'Message',datafield: 'message', width: '8%'}, 
    					{ text: 'User',datafield: 'user', width: '8%'}, 
    					{ text: 'Status',datafield: 'status', width: '8%'}, 
    					{ text: 'Assignuser',datafield: 'ass_user', width: '12%',hidden:true},  
    					{ text: 'createuser',datafield: 'userid', width: '12%',hidden:true},
    	              ]                                         
                }); 
        $("#overlay, #PleaseWait").hide();
        $('#dispatchGrid').on('rowdoubleclick', function (event) {       
            
            var rowindex2 = event.args.rowindex;                      
            document.getElementById("dispatchdocno").value=$('#dispatchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no"); 
            document.getElementById("txtenqno").value=$('#dispatchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no"); 
            document.getElementById("dispatchasgnuser").value=$('#dispatchGrid').jqxGrid('getcellvalue', rowindex2, "ass_user");
            document.getElementById("dispatchcrtuser").value=$('#dispatchGrid').jqxGrid('getcellvalue', rowindex2, "userid");
            document.getElementById("dispatcholdstatus").value=$('#dispatchGrid').jqxGrid('getcellvalue', rowindex2, "status");
            document.getElementById("txtrefname").value=$('#dispatchGrid').jqxGrid('getcellvalue', rowindex2, "client");
            var crtuser=$('#dispatchGrid').jqxGrid('getcellvalue', rowindex2, "userid");
            fundisstatusval(crtuser); 
            $('.textpanel p').text('Doc No '+$('#dispatchGrid').jqxGrid('getcellvalue',rowindex2,'doc_no')+' - '+$('#dispatchGrid').jqxGrid('getcellvalue', rowindex2, "client"));
            $('.comments-container').html('');
            $("#overlay, #PleaseWait").show();
        	$('#disflwupdiv').load('dispatchfollowupGrid.jsp?docno='+$('#dispatchGrid').jqxGrid('getcellvalue', rowindex2, "doc_no")+'&check='+1);    
        });   

	});
</script>
<div id="dispatchGrid"></div>