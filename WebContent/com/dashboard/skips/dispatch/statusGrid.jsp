<%@page import="com.dashboard.skips.dispatch.ClsDispatchDAO"%>
<%   
ClsDispatchDAO sd=new ClsDispatchDAO();                   
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
 <%
     String enqdate=request.getParameter("enqdate")==null?"0":request.getParameter("enqdate").toString();
     String enqno=request.getParameter("enqno")==null?"0":request.getParameter("enqno").toString();
     String id=request.getParameter("id")==null?"0":request.getParameter("id").toString();
 %>                
<script type="text/javascript">    
var statdata;    
statdata='<%=sd.statusGridLoad(session,id) %>';                        
       
$(document).ready(function(){

        var source =
        {
            datatype: "json",    
            datafields: [
                      	{name : 'count' , type: 'string'},
 						{name : 'count1', type: 'string'},
 						{name : 'count2', type:'string'},
 						{name : 'count3',type:'string'},
 						{name : 'count4',type:'string'},
                      	{name : 'status', type: 'string'  },
                      	{name : 'cnew',type:'string'},
                      	{name : 'crenew',type:'string'},
                      	 
             ],
             localdata: statdata,
            
            
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



        $("#statusGrid").jqxGrid(  
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
    					{ text: 'Status',datafield: 'status'},
    					{ text: 'Nos',datafield: 'count', width: '9%',cellsalign:'right',align:'right'},  
    					{ text: 'New',datafield: 'cnew', width: '9%',cellsalign:'right',align:'right'},
    					{ text: 'Renewal',datafield: 'crenew', width: '9%',cellsalign:'right',align:'right'},
    					{ text: '0-7(days)',datafield: 'count1', width: '9%',cellsalign:'right',align:'right'},
    					{ text: '8-14(days)',datafield: 'count2', width: '9%',cellsalign:'right',align:'right'},        
    					{ text: '14-21(days)',datafield: 'count3', width: '9%',cellsalign:'right',align:'right'},
    					{ text: '>21(days)',datafield: 'count4', width: '9%',cellsalign:'right',align:'right'},
    	              ]                 
                });      
	});
</script>
<div id="statusGrid"></div>