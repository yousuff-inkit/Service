<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.propertymanagement.ClsPropertyManagementDAO"%>
<%
	String id = request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").trim();
	String year = request.getParameter("year")==null || request.getParameter("year")==""?"0":request.getParameter("year").trim();
	String month = request.getParameter("month")==null || request.getParameter("month")==""?"0":request.getParameter("month").trim();
	ClsPropertyManagementDAO DAO= new ClsPropertyManagementDAO();
%>
<style type="text/css">   
    .redClass
    {
        background-color: #FFA28E;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
       
     .orangeClass
    {
        background-color: #FFEBC2;
    }
     .greenClass
    {
        background-color: #ACF6CB;
    }
</style>
<script type="text/javascript">
       var padata;
    		padata='<%=DAO.getPropertyData(id,year,month)%>';       

$(document).ready(function () {
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
						{name : 'vocno', type: 'String'  },
                        {name : 'docno', type: 'String'  },
                        {name : 'unitno', type: 'String'  },
                        {name : 'name', type: 'String'  },
                        {name : 'desc1', type: 'String'  },
                        {name : 'day1', type: 'String'  },
                        {name : 'day2', type: 'String'  },
                        {name : 'day3', type: 'String'  },
                        {name : 'day4', type: 'String'  },
                        {name : 'day5', type: 'String'  },
                        {name : 'day6', type: 'String'  },
                        {name : 'day7', type: 'String'  },
                        {name : 'day8', type: 'String'  },
                        {name : 'day9', type: 'String'  },
                        {name : 'day10', type: 'String'  },
                        {name : 'day11', type: 'String'  },
                        {name : 'day12', type: 'String'  },
                        {name : 'day13', type: 'String'  },
                        {name : 'day14', type: 'String'  },
                        {name : 'day15', type: 'String'  },
                        {name : 'day16', type: 'String'  },
                        {name : 'day17', type: 'String'  },
                        {name : 'day18', type: 'String'  },
                        {name : 'day19', type: 'String'  },
                        {name : 'day20', type: 'String'  },
                        {name : 'day21', type: 'String'  },
                        {name : 'day22', type: 'String'  },
                        {name : 'day23', type: 'String'  },
                        {name : 'day24', type: 'String'  },
                        {name : 'day25', type: 'String'  },
                        {name : 'day26', type: 'String'  },
                        {name : 'day27', type: 'String'  },
                        {name : 'day28', type: 'String'  },
                        {name : 'day29', type: 'String'  },
                        {name : 'day30', type: 'String'  },
                        {name : 'day31', type: 'String'  },
                        {name : 'brhid', type: 'String'  },    
                        {name : 'srno', type: 'String'  },  
                        {name : 'sub', type: 'String'  },  
                        {name : 'rtlrowno', type: 'String'  }, 
						],
				    localdata: padata,
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    cellclassname1 = function (row, column, value, data) {
    	 if (data.day1 =="A") {
    	       return "greenClass";
    	   }else  if (data.day1 =="R"){
       	return "greenClass";   
        }else{};
}; 
cellclassname2 = function (row, column, value, data) {
	 if (data.day2 =="A") {
	       return "greenClass";
	   }else  if (data.day2 =="R"){
     	 return "greenClass";   
    }else{};
};
cellclassname3 = function (row, column, value, data) {
	 if (data.day3 =="A") {
	       return "greenClass";
	   }else if (data.day3 =="R"){
  	return "greenClass";   
   }else{};
}; 
cellclassname4 = function (row, column, value, data) {
	 if (data.day4 =="A") {
       return "greenClass";
   }else if (data.day4 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname5 = function (row, column, value, data) {
	 if (data.day5 =="A") {
      return "greenClass";
   }else if (data.day5 =="R"){
  	return "greenClass";   
   }else{};
}; 
cellclassname6 = function (row, column, value, data) {
	 if (data.day6 =="A") {
       return "greenClass";
   }else if (data.day6 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname7 = function (row, column, value, data) {
	 if (data.day7 =="A") {
      return "greenClass";
   }else if (data.day7 =="R"){
  	return "greenClass";   
   }else{};
}; 
cellclassname8 = function (row, column, value, data) {
	 if (data.day8 =="A") {
       return "greenClass";
   }else if (data.day8 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname9 = function (row, column, value, data) {
	 if (data.day9 =="A") {
      return "greenClass";
   }else if (data.day9 =="R"){
  	return "greenClass";   
   }else{};
}; 
cellclassname10 = function (row, column, value, data) {
	 if (data.day10 =="A") {
       return "greenClass";
   }else if (data.day10 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname11 = function (row, column, value, data) {
	 if (data.day11 =="A") {
      return "greenClass";
   }else if (data.day11 =="R"){
  	return "greenClass";   
   }else{};
}; 
cellclassname12 = function (row, column, value, data) {
	 if (data.day12 =="A") {
       return "greenClass";
   }else if (data.day12 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname13 = function (row, column, value, data) {
	 if (data.day13 =="A") {
      return "greenClass";
   }else if (data.day13 =="R"){
  	return "greenClass";   
   }else{};
}; 
cellclassname14 = function (row, column, value, data) {
	 if (data.day14 =="A") {
       return "greenClass";
   }else if (data.day14 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname15 = function (row, column, value, data) {
	 if (data.day15 =="A") {
       return "greenClass";
   }else if (data.day15 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname16 = function (row, column, value, data) {
	 if (data.day16 =="A") {
       return "greenClass";
   }else if (data.day16 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname17 = function (row, column, value, data) {
	 if (data.day17 =="A") {
       return "greenClass";
   }else if (data.day17 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname18 = function (row, column, value, data) {
	 if (data.day18 =="A") {
       return "greenClass";
   }else if (data.day18 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname19 = function (row, column, value, data) {
	 if (data.day19 =="A") {
       return "greenClass";
   }else if (data.day19 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname20 = function (row, column, value, data) {
	 if (data.day20 =="A") {
       return "greenClass";
   }else if (data.day20 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname21 = function (row, column, value, data) {
	 if (data.day21 =="A") {
       return "greenClass";
   }else if (data.day21 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname22 = function (row, column, value, data) {
	 if (data.day22 =="A") {
       return "greenClass";
   }else if (data.day22 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname23 = function (row, column, value, data) {
	 if (data.day23 =="A") {
       return "greenClass";
   }else if (data.day23 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname24 = function (row, column, value, data) {
	 if (data.day24 =="A") {
       return "greenClass";
   }else if (data.day24 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname25 = function (row, column, value, data) {
	 if (data.day25 =="A") {
       return "greenClass";
   }else if (data.day25 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname26 = function (row, column, value, data) {
	 if (data.day26 =="A") {
       return "greenClass";
   }else if (data.day26 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname27 = function (row, column, value, data) {
	 if (data.day27 =="A") {
       return "greenClass";
   }else if (data.day27 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname28 = function (row, column, value, data) {
	 if (data.day28 =="A") {
       return "greenClass";
   }else if (data.day28 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname29 = function (row, column, value, data) {
	 if (data.day29 =="A") {
       return "greenClass";
   }else if (data.day29 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname30 = function (row, column, value, data) {
	 if (data.day30 =="A") {
       return "greenClass";
   }else if (data.day30 =="R"){
    	 return "greenClass";   
   }else{};
};
cellclassname31 = function (row, column, value, data) {
	 if (data.day31 =="A") {
       return "greenClass";
   }else if (data.day31 =="R"){
    	 return "greenClass";   
   }else{};
};

    var dataAdapter = new $.jqx.dataAdapter(source,
  		 {
      		loadError: function (xhr, status, error) {
              alert(error);    
             }		            
        }		
    );
    
    $("#pagrid").jqxGrid(
    {
        width: '100%',
        height: 540,
        source: dataAdapter,
        enableAnimations: true,
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlerow',                 
       	showfilterrow: true,
        sortable:true,                                
        pagermode: 'default',
        enabletooltips:true,
        editable:false,
        columns: [   
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '4%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },  
	               { text: 'Property', datafield: 'name'},       
	               { text: 'Unit No', datafield: 'unitno', width: '6%'},
	               { text: 'Sub', datafield: 'sub', width: '8%'},
	               { text: 'Description', datafield: 'desc1', width: '10%'},
	               { text: '1', datafield: 'day1', width: '2%',cellclassname:cellclassname1},
	               { text: '2', datafield: 'day2', width: '2%',cellclassname:cellclassname2},
	               { text: '3', datafield: 'day3', width: '2%',cellclassname:cellclassname3},
	               { text: '4', datafield: 'day4', width: '2%',cellclassname:cellclassname4},
	               { text: '5', datafield: 'day5', width: '2%',cellclassname:cellclassname5},
	               { text: '6', datafield: 'day6', width: '2%',cellclassname:cellclassname6},
	               { text: '7', datafield: 'day7', width: '2%',cellclassname:cellclassname7},
	               { text: '8', datafield: 'day8', width: '2%',cellclassname:cellclassname8},
	               { text: '9', datafield: 'day9', width: '2%',cellclassname:cellclassname9},
	               { text: '10', datafield: 'day10', width: '2%',cellclassname:cellclassname10},
	               { text: '11', datafield: 'day11', width: '2%',cellclassname:cellclassname11},
	               { text: '12', datafield: 'day12', width: '2%',cellclassname:cellclassname12},
	               { text: '13', datafield: 'day13', width: '2%',cellclassname:cellclassname13},
	               { text: '14', datafield: 'day14', width: '2%',cellclassname:cellclassname14},
	               { text: '15', datafield: 'day15', width: '2%',cellclassname:cellclassname15},
	               { text: '16', datafield: 'day16', width: '2%',cellclassname:cellclassname16},
	               { text: '17', datafield: 'day17', width: '2%',cellclassname:cellclassname17},
	               { text: '18', datafield: 'day18', width: '2%',cellclassname:cellclassname18},
	               { text: '19', datafield: 'day19', width: '2%',cellclassname:cellclassname19},
	               { text: '20', datafield: 'day20', width: '2%',cellclassname:cellclassname20},
	               { text: '21', datafield: 'day21', width: '2%',cellclassname:cellclassname21},
	               { text: '22', datafield: 'day22', width: '2%',cellclassname:cellclassname22},
	               { text: '23', datafield: 'day23', width: '2%',cellclassname:cellclassname23},   
	               { text: '24', datafield: 'day24', width: '2%',cellclassname:cellclassname24},
	               { text: '25', datafield: 'day25', width: '2%',cellclassname:cellclassname25},
	               { text: '26', datafield: 'day26', width: '2%',cellclassname:cellclassname26},
	               { text: '27', datafield: 'day27', width: '2%',cellclassname:cellclassname27},
	               { text: '28', datafield: 'day28', width: '2%',cellclassname:cellclassname28},
	               { text: '29', datafield: 'day29', width: '2%',cellclassname:cellclassname29},
	               { text: '30', datafield: 'day30', width: '2%',cellclassname:cellclassname30},   
	               { text: '31', datafield: 'day31', width: '2%',cellclassname:cellclassname31},  
	               { text: 'docno', datafield: 'docno', width: '4%',hidden:true},
	               { text: 'vocno', datafield: 'vocno', width: '4%',hidden:true},
	               { text: 'brhid', datafield: 'brhid', width: '4%',hidden:true},  
	               { text: 'srno', datafield: 'srno', width: '4%',hidden:true},
	               { text: 'rtlrowno', datafield: 'rtlrowno', width: '4%',hidden:true},     
	         ] 
    });
    $("#overlay, #PleaseWait").hide();
     $('#pagrid').on('rowdoubleclick', function (event) {           
            var rowindex2 = event.args.rowindex;    
            document.getElementById("hiddocno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "docno");
            document.getElementById("hidsrno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "srno");   
            document.getElementById("hidvocno").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "vocno");
            document.getElementById("hidbrhid").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "brhid");
            document.getElementById("hidlblname").value=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "vocno")+" - "+$('#pagrid').jqxGrid('getcellvalue', rowindex2, "name");
            document.getElementById("selectedrow").innerHTML=$('#pagrid').jqxGrid('getcellvalue', rowindex2, "vocno")+" - "+$('#pagrid').jqxGrid('getcellvalue', rowindex2, "name")+" - "+$('#pagrid').jqxGrid('getcellvalue', rowindex2, "sub");
            $('.comments-container').html('');                       
        });   
});
</script>
<div id="pagrid"></div>