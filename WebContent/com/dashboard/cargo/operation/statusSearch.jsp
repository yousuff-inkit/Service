<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%>
<%ClsOperationDAO assignment=new ClsOperationDAO(); %>

<script type="text/javascript">
       
	   var fleetdata='<%=assignment.assetdetails()%>';          
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'string'  },
                            {name : 'name', type: 'string'  }
                           ],
                            localdata: fleetdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            // Create a jqxInput  
            
            $("#jqxStatus").jqxInput({ source: dataAdapter, displayMember: "name", valueMember: "doc_no", items: 20 ,width: '97%', height: 18,placeHolder: "Enter Status"});
            $("#jqxStatus").on('select', function (event) {     
            	  if (event.args) {
                      var item = event.args.item;                
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {
                              if (item.value == dataAdapter.records[i].doc_no) {                
                            	  document.getElementById("txtsdocno").value=dataAdapter.records[i].doc_no;
                            	  break;       
                              }
                          }
                      }  
                  }   
                }); 
        });   
    </script>
     <input id="jqxStatus"  class="p-l-5 input-sm form-control"/>