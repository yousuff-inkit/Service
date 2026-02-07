<%@page import="com.dashboard.gwinternal.companylist.ClsCompanyListDAO" %>
<% ClsCompanyListDAO DAO=new ClsCompanyListDAO();%>
<% String contextPath=request.getContextPath();%>
<%    String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %>
<script type="text/javascript">
      var data;
      var temp='<%=check%>';
      
	  	if(temp!="0"){ 
	  		   data='<%=DAO.changesDoneGridLoading(check)%>';    
	  	}
	  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
                	        { name: 'date', type: 'date' },
							{ name: 'doc_no', type: 'string' },
							{ name: 'comp_id', type: 'string' },
							{ name: 'rapath', type: 'string' },
							{ name: 'comp_code', type: 'string' },
							{ name: 'company', type: 'string' },
							{ name: 'indcode', type: 'string' },

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
                height: 500,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                editable: true,
                enabletooltips:true,
                showfilterrow:true,
            	

                columns: [
						{ text: 'Doc No', datafield: 'doc_no', editable:false, width: '7%' },
						{ text: 'Company Id', datafield: 'comp_id', editable:false, width: '10%'},
						{ text: 'RA Path', datafield: 'rapath', editable:false, width: '16%',hidden:true },
						{ text: 'Company Code', datafield: 'comp_code', editable:false, width: '20%' },
						{ text: 'Ind Code', datafield: 'indcode', editable:false, width: '10%' },
						{ text: 'Company', datafield: 'company' },
						{ text: 'Date', datafield: 'date', editable:false, width: '7%',cellsformat:'dd.MM.yyyy' },
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
	                document.getElementById("indcode").value= $('#companylistGridID').jqxGrid('getcellvalue', rowBoundIndex, "indcode");

            		   
            }); 
			
        });

</script>
<div id="companylistGridID"></div>
