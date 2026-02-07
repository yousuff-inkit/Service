<%@page import="com.dashboard.gwinternal.internalcomments.ClsInternalCommentsDAO" %>
<% ClsInternalCommentsDAO DAO=new ClsInternalCommentsDAO();%>
<% String contextPath=request.getContextPath();%>
<%    String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %>
<script type="text/javascript">
      var data;
      var temp='<%=check%>';
      
	  	if(temp!="0"){ 
	  		   data='<%=DAO.internalCommentsGridLoading(check)%>';    
	  	}
	  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{ name: 'doc_no', type: 'string' },
							{ name: 'date', type: 'date' },
							{ name: 'username', type: 'username' },
							{ name: 'cldoc_no', type: 'string' },
							{ name: 'comp_id', type: 'string' },
							{ name: 'company', type: 'string' },
							{ name: 'comment', type: 'string' },

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
            $("#companylistGridID").jqxGrid(
            {
                width: '100%',
                height: 570,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                editable: true,
                enabletooltips:true,
                showfilterrow:true,
            	

                columns: [
                		{ text: 'SL#', sortable: false, filterable: false, editable: false,
                        	groupable: false, draggable: false, resizable: false,
                        	datafield: 'sl', columntype: 'number', width: '3%',cellsrenderer: function (row, column, value) {
                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";}},
						{ text: 'Doc No', datafield: 'doc_no', editable:false,hidden:true,width: '7%' },
						{ text: 'Date & Time', datafield: 'date', editable:false,hidden:false,width: '11%', cellsformat: 'yyyy-MM-dd HH:mm:ss' },
						{ text: 'Username', datafield: 'username', editable:false,hidden:false,width: '7%' },
						{ text: 'CL Doc No', datafield: 'cldoc_no', editable:false,hidden:true,width: '7%' },
						{ text: 'Company Id', datafield: 'comp_id', editable:false, width: '8%'},
						{ text: 'Company', datafield: 'company',editable:false, width:'27%'},
						{ text: 'Comment', datafield: 'comment', editable:false, width: '44%' },
	                    ]
            });
            
            if(temp=="0"){
                $("#companylistGridID").jqxGrid("addrow", null, {});
            }
            
           
            $("#overlay, #PleaseWait").hide();

			$("#companylistGridID").on('celldoubleclick', function (event) {
          		 
            	  var datafield = event.args.datafield;
            	  var rowBoundIndex = event.args.rowindex;
          			  
	                document.getElementById("docno").value= $('#companylistGridID').jqxGrid('getcellvalue', rowBoundIndex, "doc_no");
	                document.getElementById("txtname").value= $('#companylistGridID').jqxGrid('getcellvalue', rowBoundIndex, "company");
	                document.getElementById("comment").value= $('#companylistGridID').jqxGrid('getcellvalue', rowBoundIndex, "comment");
	                document.getElementById("cldocno").value= $('#companylistGridID').jqxGrid('getcellvalue', rowBoundIndex, "cldoc_no");
            		   
            }); 
			
        });

</script>
<div id="companylistGridID"></div>
