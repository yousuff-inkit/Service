  <%@page import="com.dashboard.inkit.presalesmanagement.*"%>
     <%
     ClsPresalesmanagementDAO cmd= new ClsPresalesmanagementDAO();
     %>   
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
 <%
     String id=request.getParameter("id")==null?"0":request.getParameter("id").toString();
 String work=request.getParameter("work")==null?"0":request.getParameter("work").toString();
 %>                
<script type="text/javascript">              
var slmdata;    
slmdata='<%=cmd.presaleslogGridLoad(session,id,work) %>';                        
     
$(document).ready(function(){

        var source =
        {
            datatype: "json",    
            datafields: [
                      	{name : 'rdocno' , type: 'string'},
 						{name : 'username', type: 'string'},
 						{name : 'logdate', type: 'date'},
 						{name : 'description', type: 'string'},
 						
                      	 
             ],
             localdata: slmdata,
            
            
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



        $("#jqxwrkGrid").jqxGrid(   
                {
                	width: '100%',
                    height: 300,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'SrNo.',datafield: '',columntype:'number', width: '7%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Enqno',datafield: 'rdocno', width: '10%',hidden:true},
    					{ text: 'User',datafield: 'username', width: '25%'},
    					{ text: 'Date',datafield: 'logdate',  width: '25%'},
    					{ text: 'Description',datafield: 'description', width: '40%'},
    	              ]                 
                });      
	});
</script>
<div id="jqxwrkGrid"></div>