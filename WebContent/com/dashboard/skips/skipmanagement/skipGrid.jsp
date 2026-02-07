<%@page import="com.dashboard.skips.skipmanagement.ClsSkipManagementDAO"%>   
<%
  ClsSkipManagementDAO sd=new ClsSkipManagementDAO();      
%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
   
 <%
     String id=request.getParameter("id")==null?"":request.getParameter("id").toString();
     String divname=request.getParameter("divname")==null?"":request.getParameter("divname").toString();
  /*    String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
     String fromdate=request.getParameter("fromdate")==null || request.getParameter("fromdate")==""?"0":request.getParameter("fromdate").toString();
	 String todate=request.getParameter("todate")==null || request.getParameter("todate")==""?"0":request.getParameter("todate").toString();  
	 String fdatechk=request.getParameter("fdatechk")==null || request.getParameter("fdatechk")==""?"0":request.getParameter("fdatechk").toString();    */
 %>        
<script type="text/javascript">    
var data;
data='<%=sd.skipData(session,id) %>';                                            
$(document).ready(function(){           
    
    var source =
    {             
            datatype: "json",
            datafields: [ 
	                    {name : 'code' , type: 'string'},
						{name : 'name', type: 'string'},
						{name : 'type', type: 'String'  },
						{name : 'typeid', type: 'number'  }, 
						{name : 'doc_no' , type: 'string'},
             ],                  
             localdata: data,    
              
            
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



        $("#jqxSkipGrid").jqxGrid(
                {
                	width: '100%',
                    height: 430,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    sortable: true,
                     columnsresize: true,
                    //Add row method
                    columns: [  
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
							    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							}   }, 
							
							{ text: 'DOC NO',datafield: 'doc_no', width: '8%'},
							{ text: 'CODE',datafield: 'code', width: '10%'},      
	    					{ text: 'NAME',datafield: 'name'},   
							{ text: 'TYPE', datafield: 'type', width: '10%'},    
							{ text: 'TYPE ID', datafield: 'typeid', width: '10%',hidden:true},  
					   ]                                                  
                });  
                $("#overlay, #PleaseWait").hide();
                $('#jqxSkipGrid').on('rowdoubleclick', function (event) {         
	                   var rowindex = event.args.rowindex;   
	                   document.getElementById("hiddocno").value=$('#jqxSkipGrid').jqxGrid('getcellvalue',rowindex,'doc_no');     
	                   $('.textpanel p').text('Doc No '+$('#jqxSkipGrid').jqxGrid('getcellvalue',rowindex,'doc_no')+' - '+$('#jqxSkipGrid').jqxGrid('getcellvalue', rowindex, "name"));
	                   $('.comments-container').html('');     
                });       
	});     
</script>
<div id="jqxSkipGrid"></div>    