
 
 <%@page import="com.dashboard.aviation.pricemanagementlist.ClsPriceManagementListDAO"%>
 <% ClsPriceManagementListDAO searchDAO = new ClsPriceManagementListDAO(); %>
 <% String chk =request.getParameter("datechk")==null?"0":request.getParameter("datechk").toString(); %>
<% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString(); %>
 
   <% String sortby =request.getParameter("sortby")==null?"0":request.getParameter("sortby").toString();%>
  <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
  <% String portid =request.getParameter("portid")==null?"0":request.getParameter("portid").toString();%>
  <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());%>

 <style type="text/css">
   .advanceClass
   {
       color: #FF0000;
   }
   .yellowClass
         {
        background-color: #ffc0cb; 
         }
 </style>
  
 <script type="text/javascript">

 var data;
 var id='<%= id%>';
 if(id>0){
 data= '<%=searchDAO.loadGridData(session,fromdate,chk)%>'; 
 }else{
 	data;
 }
  
 $(document).ready(function () {
   
	 var rendererstring=function (aggregates){
        	var value=aggregates['sum'];
        	if(typeof(value) == "undefined"){
        		value=0.00;
        	}
        	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
        }
 	
 	var rendererstring1=function (aggregates){
         var value1=aggregates['sum1'];
         return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
        }
	 
    var source =
     {
         datatype: "json",
         datafields: [   
                      {name :'voc_no', type:'number' },
                      {name :'dtype', type:'String' },
                      {name :'unit', type:'String' },
                      {name :'validfrm', type:'date' },
                      {name :'validupto', type:'date' },
                      {name :'refname', type:'String' },
                      {name :'productname', type:'String' },
                      {name :'currency', type:'String' },
 				     {name : 'port', type: 'number'  },
 				     {name :'region', type:'String' },
 				    {name : 'price', type: 'number'   },
						{name : 'tax', type: 'string'   },
						{name : 'itax', type: 'string'   },
 				    ],
 				    localdata: data,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
     };
    var cellclassname =  function (row, column, value, data) {
    
    }
    
     
     var dataAdapter = new $.jqx.dataAdapter(source,
     		 {
         		loadError: function (xhr, status, error) {
                 alert(error);    
                 }
 		            
 	            }		
     );
     
     
    
    
     
     $("#pricemgmtlistgrid").jqxGrid(
     {
         width: '98%',
         height: 505,
         statusbarheight:25,
         source: dataAdapter,
         enableAnimations: true,
         filtermode:'excel',
         filterable: true,
         showfilterrow:true,
         enabletooltips:true,
         sortable:true,
         showaggregates:true,
         selectionmode: 'singlerow',
         pagermode: 'default',
         editable:false,
         showstatusbar:true,
         columns: [  
                     /// doc_no, voc_no, date, type, expdeldt, qty, brand, model, color  
                      { text: 'DOC NO',datafield: 'voc_no', width: '5%' },
                      { text: 'DTYPE', datafield: 'dtype', width: '5%'},
                      { text: 'VALID FROM',datafield: 'validfrm', cellsformat: 'dd.MM.yyyy', width: '6%' },
                      { text: 'VALID TO',datafield: 'validupto', cellsformat: 'dd.MM.yyyy', width: '6%' },
                      { text: 'CLIENT', datafield: 'refname'},
                      { text: 'PRODUCT', datafield: 'productname', width: '10%'},
                      { text: 'PORT', datafield: 'port',  width: '7%' },
                      { text: 'REGION',datafield: 'region', width: '8%'},
                      { text: 'UNIT', datafield: 'unit', width: '5%' , editable: false},
                      { text: 'PRICE', datafield: 'price', width: '7%' ,cellsformat: 'd2', align: 'right', cellsalign: 'right'},
                      { text: 'CURR',datafield: 'currency', width: '4%'},
                      { text: 'TAX(Per Rate)', datafield: 'tax', width: '8%' ,cellsformat: 'd2', align: 'right', cellsalign: 'right', editable: false},
                      { text: 'TAX(Per Invoice)', datafield: 'itax', width: '8%' ,cellsformat: 'd2', align: 'right', cellsalign: 'right', editable: false},
            	  	]
    
     });
     $("#overlay, #PleaseWait").hide();
    
 });


 </script>
 <div id="pricemgmtlistgrid"></div>