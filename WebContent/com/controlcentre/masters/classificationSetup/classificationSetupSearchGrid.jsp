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
var data = '<%=DAO.specMasterSearchLoad(session)%>';
$(document).ready(function(){
	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'  },
     						{name : 'name', type: 'string' },
     						{name:'date', type:'date'}     							    						
                        ],
                         localdata:data,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxspecMasterSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 400,
                source: dataAdapter,
                editable: false,
                altRows:true,
                showfilterrow:true,
                filterable:true,
                selectionmode: 'singlerow', 
                       
                columns: [
							{text:'Doc No', datafield:'doc_no', width:'6%', align: 'center',cellsalign:'right'},
							{text:'Date',datafield:'date', width:'8%',align:'center',cellsalign:'center',cellsformat:'dd.MM.yyyy'},
							{text:'Name', datafield:'name', width:'86%', align:'center',cellsalign:'left'}
						 ]
            });
            
            
			  $('#jqxspecMasterSearchGrid').on('celldoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#jqxspecMasterSearchGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("name").value= $('#jqxspecMasterSearchGrid').jqxGrid('getcellvalue', rowindex1, "name");
                
                	$('#specDate').jqxDateTimeInput({disabled: false});
	                $("#specDate").val($("#jqxspecMasterSearchGrid").jqxGrid('getcellvalue', rowindex1, "date"));
	                $('#specDate').jqxDateTimeInput({disabled: false});
                $('#window').jqxWindow('close');
            });

});
</script>
<div id="jqxspecMasterSearchGrid"></div>