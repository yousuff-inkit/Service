<%@page import="com.dashboard.audit.formenable.ClsFormEnableDAO" %>
<% ClsFormEnableDAO DAO=new ClsFormEnableDAO();%>
<% String rpttype = request.getParameter("rpttype")==null?"0":request.getParameter("rpttype").trim();
   String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %>
<script type="text/javascript">
      var data;
      var temp='<%=check%>';
      var rpttype='<%=rpttype%>';
      
	  	if(temp=='1'){ 
	  		  data='<%=DAO.menuGridLoading(rpttype,check)%>';  
	  	}
  	
        $(document).ready(function () {
          	
        	var source =
            {
                datatype: "json",
                datafields: [
								{ name: 'path', type: 'string' },
								{ name: 'printpath', type: 'string' },
			                    { name: 'printpath2', type: 'string' },
			                    { name: 'doc_type', type: 'string' },
			                    { name: 'mno', type: 'int' },
			                    { name: 'gate', type: 'string' },
			                    {name : 'menu_name', type: 'string'  },
								{name : 'enable', type: 'String'  }

				            ],
			                localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        
        	var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#menuGridID").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: true,
                enabletooltips:true,
                showfilterrow:true,
                
                columns: [
						{ text: 'Form', datafield: 'menu_name', width: '15%', editable: false },
	                    { text: 'Path', datafield: 'path' , editable: false},
	                    { text: 'Print Path', datafield: 'printpath', width: '20%' , editable: false},
	                    { text: 'Print Path 2', datafield: 'printpath2', width: '20%' , editable: false},
	                    { text: 'Dtype', datafield: 'doc_type', width: '10%' , editable: false},
	                    { text: 'Gate', datafield: 'gate', width: '10%', editable: true },
	                    { text: 'Doc No', hidden: true, datafield: 'mno', width: '10%', editable: false },
					//	{ text: 'Enable', datafield: 'enable', width: '6%', columntype: 'button', editable:false, filterable: false},

					 ]
            });
            
            if(rpttype=="2")
        	{
        	
        	   $('#menuGridID').jqxGrid('hidecolumn', 'printpath2');
        	}
        else if(rpttype=="1")
        	{
     	   $('#menuGridID').jqxGrid('showcolumn', 'printpath2');
        	
        	}
           
            $("#overlay, #PleaseWait").hide();
            
            $('#menuGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
            	document.getElementById("hiddocno").value = $('#menuGridID').jqxGrid('getcellvalue', rowindex1, "mno");
            	document.getElementById("txtpath").value = $('#menuGridID').jqxGrid('getcellvalue', rowindex1, "path");
            	document.getElementById("txtprintpath").value = $('#menuGridID').jqxGrid('getcellvalue', rowindex1, "printpath");
            	document.getElementById("txtprintpath2").value = $('#menuGridID').jqxGrid('getcellvalue', rowindex1, "printpath2");

               
            });  
            
            
            $('#menuGridID').on('cellvaluechanged', function (event) {
                var rowindex1 = event.args.rowindex;
            	document.getElementById("hiddocno").value = $('#menuGridID').jqxGrid('getcellvalue', rowindex1, "mno");
            	document.getElementById("hidgate").value = $('#menuGridID').jqxGrid('getcellvalue', rowindex1, "gate");
          	
               
            });  
           

        });

</script>
<div id="menuGridID"></div>
