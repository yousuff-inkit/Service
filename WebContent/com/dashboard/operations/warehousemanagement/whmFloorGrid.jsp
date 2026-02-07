<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.operations.warehousemanagement.ClsWarehouseManagementDAO"%>
<%
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    ClsWarehouseManagementDAO DAO= new ClsWarehouseManagementDAO();   
%>
<style type="text/css">
.redClass {
	background-color: #FCBDBD;
}

.greenClass {
	background-color: #A8FDA7;
}

.orangeClass {
	background-color: #FFEBC2;
}
</style>
<script type="text/javascript">  
       var data4;
       data4='<%=DAO.getFloorData(id)%>';                                    

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'rack', type: 'String'  },
						{name : 'floor', type: 'String'  },
						{name : 'rackid', type: 'String'  },   
                        {name : 'bin1', type: 'String'  },   
                        {name : 'bin2', type: 'String'  }, 
                        {name : 'bin3', type: 'String'  }, 
                        {name : 'bin4', type: 'String'  }, 
                        {name : 'bin5', type: 'String'  }, 
                        {name : 'bin6', type: 'String'  }, 
                        {name : 'bin7', type: 'String'  }, 
                        {name : 'bin8', type: 'String'  }, 
                        {name : 'bin9', type: 'String'  },
                        {name : 'bin10', type: 'String'  }, 
                        {name : 'bin11', type: 'String'  }, 
                        {name : 'bin12', type: 'String'  },
                        {name : 'bin13', type: 'String'  },
                        {name : 'bin14', type: 'String'  },
                        {name : 'bin15', type: 'String'  },
                        {name : 'bin16', type: 'String'  },
                        {name : 'bin17', type: 'String'  },
                        {name : 'bin18', type: 'String'  },
                        {name : 'bin19', type: 'String'  },
                        {name : 'bin20', type: 'String'  },   
						],
				    localdata: data4,

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
    var cellclassname1 = function (row, column, value, data) {
    	var bin1=data.bin1.split('##');
    	if (bin1[2]==" F") {  
            return "redClass";
        }else{
        	 return "greenClass";  
        }  
       };
    var cellclassname2 = function (row, column, value, data) {
       	var bin2=data.bin2.split('##');
       	if (bin2[2]==" F") {  
               return "redClass";
           }else{
           	 return "greenClass";  
           }  
      };
      var cellclassname3 = function (row, column, value, data) {
      	var bin3=data.bin3.split('##');
      	if (bin3[2]==" F") {  
              return "redClass";
          }else{
          	 return "greenClass";  
          }  
       };
       var cellclassname4 = function (row, column, value, data) {
         	var bin4=data.bin4.split('##');
         	if (bin4[2]==" F") {  
                 return "redClass";
             }else{
             	 return "greenClass";  
             }  
       };
       var cellclassname5 = function (row, column, value, data) {
       	var bin5=data.bin5.split('##');
       	if (bin5[2]==" F") {  
               return "redClass";
           }else{
           	 return "greenClass";  
           }  
      };
      var cellclassname6 = function (row, column, value, data) {
      	var bin6=data.bin6.split('##');
      	if (bin6[2]==" F") {  
              return "redClass";
          }else{
          	 return "greenClass";  
          }  
      };
      var cellclassname7 = function (row, column, value, data) {
      	var bin7=data.bin7.split('##');
      	if (bin7[2]==" F") {  
              return "redClass";
          }else{
          	 return "greenClass";  
          }  
      };
      var cellclassname8 = function (row, column, value, data) {
      	var bin8=data.bin8.split('##');
      	if (bin8[2]==" F") {  
              return "redClass";
          }else{
          	 return "greenClass";  
          }  
       };
       var cellclassname9 = function (row, column, value, data) {
       	var bin9=data.bin9.split('##');
       	if (bin9[2]==" F") {  
               return "redClass";
           }else{
           	 return "greenClass";  
           }  
        };
        var cellclassname10 = function (row, column, value, data) {
        	var bin10=data.bin10.split('##');
        	if (bin10[2]==" F") {  
                return "redClass";
            }else{
            	 return "greenClass";  
            }  
         };
         var cellclassname11 = function (row, column, value, data) {
         	var bin11=data.bin11.split('##');
         	if (bin11[2]==" F") {  
                 return "redClass";
             }else{
             	 return "greenClass";  
             }  
          }; 
          var cellclassname12 = function (row, column, value, data) {
           	var bin12=data.bin12.split('##');
           	if (bin12[2]==" F") {  
                   return "redClass";
               }else{
               	 return "greenClass";  
               }  
         }; 
         var cellclassname13 = function (row, column, value, data) {
          	var bin13=data.bin13.split('##');
          	if (bin13[2]==" F") {  
                  return "redClass";
              }else{
              	 return "greenClass";  
              }  
        };
        var cellclassname14 = function (row, column, value, data) {
         	var bin14=data.bin14.split('##');
         	if (bin14[2]==" F") {  
                 return "redClass";
             }else{
             	 return "greenClass";  
             }  
          };
          var cellclassname15 = function (row, column, value, data) {
           	var bin15=data.bin15.split('##');
           	if (bin15[2]==" F") {  
                   return "redClass";
               }else{
               	 return "greenClass";  
               }  
         };
         var cellclassname16 = function (row, column, value, data) {
          	var bin16=data.bin16.split('##');
          	if (bin16[2]==" F") {  
                  return "redClass";
              }else{
              	 return "greenClass";  
              }  
         };
         var cellclassname17 = function (row, column, value, data) {
          	var bin17=data.bin17.split('##');
          	if (bin17[2]==" F") {  
                  return "redClass";
              }else{
              	 return "greenClass";  
              }  
          };
          var cellclassname18 = function (row, column, value, data) {
           	var bin18=data.bin18.split('##');
           	if (bin18[2]==" F") {  
                   return "redClass";
               }else{
               	 return "greenClass";  
               }  
        };
        var cellclassname19 = function (row, column, value, data) {
         	var bin19=data.bin19.split('##');
         	if (bin19[2]==" F") {  
                 return "redClass";
             }else{
             	 return "greenClass";  
             }  
          };
          var cellclassname20 = function (row, column, value, data) {
           	var bin20=data.bin20.split('##');
           	if (bin20[2]==" F") {  
                   return "redClass";
               }else{
               	 return "greenClass";  
               }   
            }; 
    $("#jqxwhmFloorGrid").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        enableAnimations: true,
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlecell',                 
       	showfilterrow: true,
        sortable:true,                                
        pagermode: 'default',
        enabletooltips:true,
        columns: [   
					{ text: 'SL#', sortable: false, filterable: false,       
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '4%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },  
				   { text: 'rackid', datafield: 'rackid', width: '6%',hidden:true}, 
				   { text: 'Floor', datafield: 'floor', width: '6%'},   
				   { text: 'Rack', datafield: 'rack', width: '6%'},   
				   { text: '1', datafield: 'bin1', width: '5%',cellclassname:cellclassname1},
				   { text: '2', datafield: 'bin2', width: '5%',cellclassname:cellclassname2},
				   { text: '3', datafield: 'bin3', width: '5%',cellclassname:cellclassname3},
				   { text: '4', datafield: 'bin4', width: '5%',cellclassname:cellclassname4},
				   { text: '5', datafield: 'bin5', width: '5%',cellclassname:cellclassname5},
				   { text: '6', datafield: 'bin6', width: '5%',cellclassname:cellclassname6},
				   { text: '7', datafield: 'bin7', width: '5%',cellclassname:cellclassname7},
				   { text: '8', datafield: 'bin8', width: '5%',cellclassname:cellclassname8},
				   { text: '9', datafield: 'bin9', width: '5%',cellclassname:cellclassname9},
				   { text: '10', datafield: 'bin10', width: '6%',cellclassname:cellclassname10},
				   { text: '11', datafield: 'bin11', width: '6%',cellclassname:cellclassname11},
				   { text: '12', datafield: 'bin12', width: '6%',cellclassname:cellclassname12},
				   { text: '13', datafield: 'bin13', width: '6%',cellclassname:cellclassname13},
				   { text: '14', datafield: 'bin14', width: '6%',cellclassname:cellclassname14},
				   { text: '15', datafield: 'bin15', width: '6%',cellclassname:cellclassname15},
				   { text: '16', datafield: 'bin16', width: '6%',cellclassname:cellclassname16},
				   { text: '17', datafield: 'bin17', width: '6%',cellclassname:cellclassname17},
				   { text: '18', datafield: 'bin18', width: '6%',cellclassname:cellclassname18},
				   { text: '19', datafield: 'bin19', width: '6%',cellclassname:cellclassname19},
				   { text: '20', datafield: 'bin20', width: '6%',cellclassname:cellclassname20},               
	         ]    
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxwhmFloorGrid').on('cellclick', function (event) {                            
        var rowindex = event.args.cellindex; 
        var columnDataField = event.args.datafield;
        var cellvalue = event.args.value;
        if(columnDataField=="bin1" || columnDataField=="bin2" || columnDataField=="bin3" || columnDataField=="bin4" || columnDataField=="bin5" || columnDataField=="bin6" || columnDataField=="bin7" || columnDataField=="bin8" || columnDataField=="bin9" || columnDataField=="bin10" || columnDataField=="bin11" || columnDataField=="bin12" || columnDataField=="bin13" || columnDataField=="bin14" || columnDataField=="bin15" || columnDataField=="bin16" || columnDataField=="bin17" || columnDataField=="bin18" || columnDataField=="bin19" || columnDataField=="bin20"){
        	if(cellvalue!=""){   
        		getBindetails(cellvalue); 
        	}
        }   
        $('.comments-container').html('');     
    }); 
});
</script>
<div id="jqxwhmFloorGrid"></div>      