<%@page import="com.finance.accountssetup.clustermaster.ClsClusterMasterDAO"%>
<%ClsClusterMasterDAO DAO= new ClsClusterMasterDAO(); %>
<% String mode = request.getParameter("mode")==null?"view":request.getParameter("mode");%>
<% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>
<style type="text/css">
  .statutoryDeductionClass
  {
      background-color: #FDF9EF;
  }
</style>
<script type="text/javascript">
		var tempMode='<%=mode%>';
		var tempDocNo='<%=docNo%>';
		var temp='0';
		
		var data;
		
        $(document).ready(function () { 	
        	
        	if(tempDocNo>0) {
         		 
          		data='<%=DAO.clusterAccountReloading(docNo)%>';
          		
          	 } else {
         		 
         		 temp='1';
         	 }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'account', type: 'string' },
     						{name : 'accountname', type: 'string' },
     						{name : 'doc_no', type: 'int'   }
                        ],
                		 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#clusterGridID").jqxGrid(
            {
            	width: '55%',
                height: 150,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
			   handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#clusterGridID').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'account') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                  	    	accountSearchContent('accountsDetailsSearch.jsp'); 
                          }
                    }
                    
                },
                
                columns: [
							{ text: 'S#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Account', datafield: 'account', editable: false, width: '30%' },
							{ text: 'Account Name', datafield: 'accountname', editable: false, width: '65%' },			
							{ text: 'Account Doc No', datafield: 'doc_no', hidden: true, width: '10%' }	
						]
            });

            //Add empty row
            if(temp=='1'){
           	   $("#clusterGridID").jqxGrid('addrow', null, {});
             }
            
            if(tempDocNo>0 && tempMode=='view'){
            	$("#clusterGridID").jqxGrid('disabled', true);
            } 
            
            $('#clusterGridID').on('celldoubleclick', function (event) {
          	  if(event.args.columnindex == 1)
          		  {
          			var rowindextemp = event.args.rowindex;
          			document.getElementById("rowindex").value = rowindextemp;
          			accountSearchContent('accountsDetailsSearch.jsp');
                    } 
              });
            
        });
</script>
<div id="clusterGridID"></div>
<input type="hidden" id="rowindex"/> 