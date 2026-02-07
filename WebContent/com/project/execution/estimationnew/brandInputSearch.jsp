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
   var branddata= '<%=DAO.brandSearch()%>';         
            $(document).ready(function () {
                  //alert("sdata"+cdata);  
               	 
                // prepare the data   
                var source =
                {
                    datatype: "json",    
                    datafields: [
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'brandname', type: 'string'  }
                    ],
                    localdata: branddata,
                };  
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput  
                   
                $("#jqxBrandInput").jqxInput({ source: dataAdapter, displayMember: "brandname", valueMember: "brandname", items: 20});
                $("#jqxBrandInput").on('select', function (event) {     
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
         <input id="jqxBrandInput" class="form-control input-sm" placeHolder="Enter Brand"/>