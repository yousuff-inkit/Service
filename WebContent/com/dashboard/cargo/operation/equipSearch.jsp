<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%>
<% ClsOperationDAO assignment=new ClsOperationDAO(); %> 
<script type="text/javascript">   
    var data2= '<%=assignment.equipmentSearch() %>';          
    $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'fleetno', type: 'string'   },
     						{name : 'flname', type: 'string'   },
     						{name : 'reg_no', type: 'string'   },
     						{name : 'trackid', type: 'string'   },
                        ],
                		localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            // Create a jqxInput  
            
            $("#jqxRegno").jqxInput({ source: dataAdapter, displayMember: "reg_no", valueMember: "fleetno", items: 20 ,width: '97%', height: 18,placeHolder: "Enter Reg No"});
            $("#jqxRegno").on('select', function (event) {          
            	  if (event.args) {
                      var item = event.args.item;                
                      if (item) {
                          for (var i = 0; i < dataAdapter.records.length; i++) {
                              if (item.value == dataAdapter.records[i].fleetno) {           
                            	  document.getElementById("hidequipmentid").value=dataAdapter.records[i].fleetno;
                            	  break;       
                              }
                          }
                      }
                  }   
                }); 
        });   
    </script>
     <input id="jqxRegno"  class="p-l-5 input-sm form-control"/>