 
<script type="text/javascript">
 
var datas111;

var list =['CTN','BAG','OTH'];

$(document).ready(function () {
	   
      
    var source =
    {
        datatype: "json",
        datafields: [    
                     
 
                        {name : 'sl', type: 'String'  },
						 
						{name : 'type', type: 'String'  }, 
						{name : 'nos', type: 'number'  },
					 
			 
						
						],
				    localdata: datas111,
        
        
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
    
    
   
   
    
    $("#sidelistgrid1").jqxGrid(
    {
        width: '100%',
        height: 150,
        source: dataAdapter,
        rowsheight:20,
         editable: true,
       
        selectionmode: 'singlecell',
        pagermode: 'default',
       
        columns: [   
                  	{ text: 'SL#', sortable: false, filterable: false, editable: false,
	                      groupable: false, draggable: false, resizable: false,
	                      datafield: 'sl', columntype: 'number', width: '5%',
	                      cellsrenderer: function (row, column, value) {
	                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	                      }  
	                    },	
	                    { text: 'NOS', datafield: 'nos', width: '20%'  },
						
	    				{ text: 'Pack Type',  datafield: 'type',  width: '68%',cellsalign: 'center',align: 'center',columntype:'dropdownlist',createeditor: function (row, column, editor) {
	                            editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
	    					  }
	    					},
	    					 
	    			
         			 
                    
                     
               
                     
           	  
					
					]
   
    });
    
     

	    $('#sidelistgrid1').on('cellvaluechanged', function (event) 
	    		{ 
    
    var rows = $('#sidelistgrid1').jqxGrid('getrows');
    
    
    var rowindex1=event.args.rowindex;
    var rowlength= rows.length;
    if(rowindex1 == rowlength - 1)
    	{  
    $("#sidelistgrid1").jqxGrid('addrow', null, {});
    	} 
    	  
	    		});
 
 
    
   
});


</script>
<div id="sidelistgrid1"></div>