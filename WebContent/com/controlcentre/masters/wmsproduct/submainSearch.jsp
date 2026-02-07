<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.controlcentre.masters.wmsproduct.ClsWmsproductDAO"%>

 <%
 ClsWmsproductDAO DAO= new ClsWmsproductDAO(); 
String name = request.getParameter("name")==null?"0":request.getParameter("name");
 String code = request.getParameter("pcode")==null?"0":request.getParameter("pcode");
 String cat = request.getParameter("cat")==null?"0":request.getParameter("cat");
 String subcat = request.getParameter("subcat")==null?"0":request.getParameter("subcat");
 String brand = request.getParameter("brand")==null?"0":request.getParameter("brand");
 String txtjde = request.getParameter("txtjde")==null?"0":request.getParameter("txtjde");
 String txtbh = request.getParameter("txtbh")==null?"0":request.getParameter("txtbh");

  
%> 
 <script type="text/javascript">
 
  var searchdata;
 searchdata='<%=DAO.mainSrearch(session,name,code,brand,cat,subcat,txtjde,txtbh)%>'; 
 
        $(document).ready(function () {  
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
              
     						{name : 'brand', type: 'String'  },
     						{name : 'category', type: 'String'  },
     						{name : 'subcategory', type: 'String'  }, 
      						{name : 'productcode', type: 'String'  },
      						{name : 'productname', type: 'string'  },
      						{name : 'docno', type: 'String'  },
      						{name : 'jdeno', type: 'string'  },
      						{name : 'bhno', type: 'string'  },

      						
                          	],
                          	localdata: searchdata,
                          
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
               
           
                selectionmode: 'singlerow',
             
               
                //Add row method
	
     						
     					
     					
                columns: [
					{ text: 'Product Code', datafield: 'productcode', width: '10%' },
					{ text: 'Product Name', datafield: 'productname', width: '35%' },
					{ text: 'Brand', datafield: 'brand', width: '10%' }, 
					{ text: 'Category', datafield: 'category', width: '10%' },
					{ text: 'Sub Category', datafield: 'subcategory', width: '10%'},
					{ text: 'Docno', datafield: 'docno', width: '12%',hidden:true},
					{ text: 'JDE No', datafield: 'jdeno', width: '12%' },
					{ text: 'BH No', datafield: 'bhno', width: '12%'},

					
					
					]
            });
    
          /*   $("#jqxmainsearch").jqxGrid('addrow', null, {}); */
      
				            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				            	
				         document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "docno");
				         document.getElementById("txtproductname").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				         document.getElementById("txtjde").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "jdeno");
				         document.getElementById("txtbh").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "bhno");
          
				                  
				                $('#window').jqxWindow('close');
				               
				                $('#frmWmsproduct txtproductname').attr('disabled', false);
				                $('#frmWmsproduct docno').attr('disabled', false); 
				                funSetlabel();
				                
				                $('#frmWmsproduct input').attr('disabled', false ); 
				                
				                document.getElementById("frmWmsproduct").submit();
				            	
				               
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
