<%@page import="com.workdetails.ClsWorkDetailsDAO" %>
<% ClsWorkDetailsDAO wd=new ClsWorkDetailsDAO();%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String formtype = request.getParameter("formType")==null?"0":request.getParameter("formType");
 String project = request.getParameter("project")==null?"0":request.getParameter("project");
 %> 

 <script type="text/javascript">
 
	var data='<%=wd.formNameLoading(formtype,project)%>';
 	
	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_type', type: 'string' },
						{name : 'menu_name', type: 'string' },
						{name : 'menu_id', type: 'string' },
						{name : 'ref_no', type: 'string' }
                    ],
            		localdata: data, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#formSearch").jqxGrid(
        {
        	width: '100%',
            height: 350,
            source: dataAdapter,
            selectionmode: 'singlerow',
            showfilterrow: true, 
            filterable: true, 
 			editable: false,
 			columnsresize: true,
            
            columns: [
					   {  text: 'Sr. No.', sortable: false, filterable: false, editable: false,
					      groupable: false, draggable: false, resizable: false,datafield: '',
					      columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
					      cellsrenderer: function (row, column, value) {
						   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					     }  
						},                          
						{ text: 'Doc Code', datafield: 'doc_type', width: '30%',editable:false, hidden:true },
						{ text: 'Menu', datafield: 'menu_name', width: '90%',editable:false },
						{ text: 'Menu Id', datafield: 'menu_id', width: '70%',editable:false,hidden:true },
						{ text: 'Ref No', datafield: 'ref_no', width: '70%',editable:false,hidden:true },
					]
        });
        
         $('#formSearch').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;
        	document.getElementById("txtformname").value = $('#formSearch').jqxGrid('getcellvalue', rowindex1, "menu_name");
        	
            $('#formDetailsWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="formSearch"></div>
    