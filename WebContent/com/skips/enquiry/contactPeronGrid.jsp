<style>
.column{
background-color: #D6FFEA;
}
</style>
<script type="text/javascript">
  	 
 function getactivity(rowBoundIndex){
	  $('#activityinfowindow').jqxWindow('open');  
	  searchContent1('activity.jsp?rowBoundIndex='+rowBoundIndex+"&act="+1,$("#activityinfowindow").attr('id'));
 }

 function getdep(rowBoundIndex){
	   $('#depinfowindow').jqxWindow('open');
	   searchContent1('department.jsp?rowBoundIndex='+rowBoundIndex,$("#depinfowindow").attr('id'));
 }
 
 function searchContent1(url, id) {
	 $.get(url).done(function (data) {
		$('#'+id).jqxWindow('bringToFront');  
		$('#'+id).jqxWindow('setContent', data);
     }); 
  }   
 
var cpdata;
  
     $(document).ready(function () { 	
            
        	 var columnsrenderer = function (value) {
        			return '<div style="text-align: center;margin-top: 5px;">' + value + '</div>';
        		}
            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
									{name : 'slno' , type: 'number', },
									{name : 'cpersion' , type:'string'},
									{name : 'mobile' , type:'string'},
									{name : 'phone' , type:'string'},
									{name : 'extn' , type:'string'},
									{name : 'email' , type:'string'},
									{name : 'area' , type:'string'},
									{name : 'areaid',type:'number'},
									{name : 'activity' , type:'string'},
									{name : 'activity_id' , type:'number'},
									{name : 'dep' , type:'string'},
									{name : 'dep_id' , type:'number'},

									],
                localdata: cpdata,
                //url: url,
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
            $("#cpDetailsGrid").jqxGrid(
            {
                width: '100%',
                height: 110,
                source: dataAdapter,
                rowsheight:18,
                columnsresize: true,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
                editable:true,
                enabletooltips:true,
                //Add row method
                
                 handlekeyboardnavigation: function (event) {
                var rows = $('#cpDetailsGrid').jqxGrid('getrows');
                var rowlength= rows.length;
                   var cell = $('#cpDetailsGrid').jqxGrid('getselectedcell'); 
                   if (cell != undefined && cell.datafield == 'activity' && cell.rowindex == rowlength - 1) {
                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       if (key ==13) {  
                           var commit = $("#cpDetailsGrid").jqxGrid('addrow', null, {});
                           rowlength++; 
                       }
                   } 
                   var cell2 = $('#cpDetailsGrid').jqxGrid('getselectedcell');
                   if (cell2 != undefined && cell2.datafield == 'activity') {
                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       if (key == 114) {
                    	   var rowBoundIndex5 =cell2.rowindex;
                   
                      		$('#cpDetailsGrid').jqxGrid('render');
                      		getactivity(rowBoundIndex5); 
                         }
                   }
                   
                   var cell3 = $('#cpDetailsGrid').jqxGrid('getselectedcell');
                   if (cell3 != undefined && cell3.datafield == 'dep') {
                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       if (key == 114) {
                    	   var rowBoundIndex6 =cell3.rowindex;
                   
                      		$('#cpDetailsGrid').jqxGrid('render');
                      		getdep(rowBoundIndex6); 
                         }
                   }
                   
                 },
                
                columns: [
						{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
						                              groupable: false, draggable: false, resizable: false,datafield: '',
						                              columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
						                              cellsrenderer: function (row, column, value) {
						                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						                              }  
						       },
						{ text: 'Contact Person',  datafield: 'cpersion',editable:true ,renderer: columnsrenderer, cellsalign: 'center', align: 'center',cellclassname:'column'},
						{ text: 'Department',  datafield: 'dep',  width: '10%',editable:false,renderer: columnsrenderer,cellsalign: 'center',align: 'center',cellclassname:'column'},
						{ text: 'Mobile No',  datafield: 'mobile',  width: '10%',editable:true,renderer: columnsrenderer,cellsalign: 'center', align: 'center',cellclassname:'column'},
						{ text: 'Telephone No',  datafield: 'phone',  width: '10%'  ,editable:true ,renderer: columnsrenderer,cellsalign: 'center',align: 'center',cellclassname:'column'},
						{ text: 'Extension',  datafield: 'extn',  width: '8%',editable:true,renderer: columnsrenderer,cellsalign: 'center', align: 'center',cellclassname:'column'},
						{ text: 'Email',  datafield: 'email',  width: '12%',editable:true,renderer: columnsrenderer,cellsalign: 'center',align: 'center',cellclassname:'column'},
						{ text: 'Area',  datafield: 'area', hidden:true, width: '12%',editable:false,renderer: columnsrenderer,cellsalign: 'center',align: 'center',cellclassname:'column'},
						{ text: 'Area id', datafield: 'areaid', width: '9%' ,editable:true,renderer: columnsrenderer,cellsalign: 'center',hidden:true,align: 'center',cellclassname:'column'},
						{ text: 'Activity',  datafield: 'activity', editable:false,renderer: columnsrenderer,cellsalign: 'center',align: 'center',cellclassname:'column'},
						{ text: 'Activity id',  datafield: 'activity_id', width: '10%'  ,editable:true,renderer: columnsrenderer,cellsalign: 'center',hidden:true,align: 'center',cellclassname:'column'},
						{ text: 'Department id',  datafield: 'dep_id',editable:true,renderer: columnsrenderer,cellsalign: 'center',hidden:true,align: 'center',cellclassname:'column'}
	              ]  
            });
	            var rows = $('#cpDetailsGrid').jqxGrid('getrows');
	           
	            var rowslength=rows.length;
	            if(rowslength==0){
	           				 $("#cpDetailsGrid").jqxGrid("addrow", null, {});
	            }
            
	            $("#cpDetailsGrid").on("celldoubleclick", function (event) {
				             var rowBoundIndex = event.args.rowindex;
				    		 var datafield = event.args.datafield;
				    		       
				    		 if(datafield=="activity") {
			    		    	   getactivity(rowBoundIndex);
			    		     }
				    		       
				    		 if(datafield=="dep"){
			    		    	   getdep(rowBoundIndex);
			    		     }
	            });
        });
 </script>
 <div id="cpDetailsGrid"></div> 