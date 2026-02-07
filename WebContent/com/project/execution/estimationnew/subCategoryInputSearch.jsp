<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
 <%@page import="com.project.execution.estimationnew.ClsEstimationDAO"%>
<%ClsEstimationDAO DAO= new ClsEstimationDAO(); %>
 
<style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
}
</style>
  <script type="text/javascript"> 
  var subcategorySearchdata= '<%=DAO.subCategorySearch()%>';        
            $(document).ready(function () {
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",    
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'subcategory', type: 'string'  }
                    ],
                    localdata: subcategorySearchdata,
                };  
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                   
                $("#jqxSubCategoryInput").jqxInput({ source: dataAdapter, displayMember: "subcategory", valueMember: "subcategory", items: 20});
                $("#jqxSubCategoryInput").on('select', function (event) {     
                	  if (event.args) {
                          var item = event.args.item;              
                          if (item) {							
                              for (var i = 0; i < dataAdapter.records.length; i++) {
                                  if (item.value == dataAdapter.records[i].doc_no) {      
                                	   
                                	  break;       
                                  }
                              }
                          }
                      }   
                    }); 
            });   
        </script>  
         <input id="jqxSubCategoryInput" class="form-control input-sm" placeHolder="Enter Sub Category"/>