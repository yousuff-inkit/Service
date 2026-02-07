<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.classificationsetup.ClsclassificationSetupDAO"%>
<%
	String contextPath=request.getContextPath();
%>
<%
	ClsclassificationSetupDAO DAO= new ClsclassificationSetupDAO();
%>
<script type="text/javascript">
var data = '<%=DAO.specMasterLoad(session)%>';
$(document).ready(function(){
	var source =
            {
                datatype: "json",
                datafields: [
							{name :'doc_no', type: 'int'},
     						{name :'name', type: 'string'},
     						{name :'date', type:'date'}     							    						
                        ],
                         localdata:data,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxspecMasterGrid").jqxGrid(
            {
                width: '100%',
                height: 400,
                editable:false,
                source: dataAdapter,
                altRows:true,
                filterable:true,
                showfilterrow:true,
                sortable:true,
                selectionmode: 'singlerow', 
                       
                columns: [
							{text:'Doc No', datafield:'doc_no', width:'6%', align: 'left',cellsalign:'left'},
							{text:'Date',datafield:'date', width:'8%',align:'left',cellsalign:'left',cellsformat:'dd.MM.yyyy'},
							{text:'Name', datafield:'name', width:'86%', align:'left',cellsalign:'left'}
						 ]
            });
            
			  $('#jqxspecMasterGrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxspecMasterGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("name").value= $('#jqxspecMasterGrid').jqxGrid('getcellvalue', rowindex1, "name"); 
                $('#specDate').jqxDateTimeInput({disabled: false});
	            $("#specDate").val($("#jqxspecMasterGrid").jqxGrid('getcellvalue', rowindex1, "date"));
	            $('#specDate').jqxDateTimeInput({disabled: true});
	            $("#deleted").val("");
	            console.log( document.getElementById("docno").value);
                console.log( document.getElementById("name").value);
               
            });

});
</script>
<div id="jqxspecMasterGrid"></div>

        