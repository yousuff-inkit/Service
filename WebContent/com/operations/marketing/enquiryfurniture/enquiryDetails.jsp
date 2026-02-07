<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.enquiryfurniture.ClsEnquiryFurnitureDAO" %>


 <%
 ClsEnquiryFurnitureDAO DAO= new ClsEnquiryFurnitureDAO();
            	String enqrdocno = request.getParameter("enqrdocno")==null?"0":request.getParameter("enqrdocno").trim();
            //System.out.println("---------"+enqrdocno);
 %> 
<script type="text/javascript">

           	  
           	var temp1='<%=enqrdocno%>';
            var hide;
            var enqdata1;
            if(temp1>0)
          	 {
            	<%--   enqdata1= '<%=DAO.searchrelode(enqrdocno,session)%>'; --%>
            	 
          	   hide=2; 
          	 } 
            else
          	 { 
            	var enqdata1;
            	var codes;
            	var list;
            	 <%-- var codes="<%=com.operations.marketing.enquiry.ClsEnquiryAction.searchTariff()%>"; --%>  
            	/*  var list = codes.split(","); */ 
          	/* 	 /* '[{"Name":""},{"Date of Birth":""},{"Age":""},{"dbage":""},{"Nationality":""},{"Mob No":""},{"Licence#":""},{"Lic Issued":""},{"dbLic Issued":""},{"calcuLic Issued":""},{"Licence#":""},{"Lic Issued":""},{"dbLic Issued":""},{"calcuLic Issued":""},{"Lic Expiry":""},{"Lic Type":""},{"Iss From":""},{"Passport#":""},{"Pass Exp":""},{"doc_no":""}]'; */
          	 } 
   <%--  var data= '<%=com.operations.marketing.enquiry.ClsEnquiryAction.searchDetails() %>'; --%>
  
        $(document).ready(function () { 	
        
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'site', type: 'String'  },
                  	{name : 'area', type: 'String'  },
                  	
     						{name : 'skiptype', type: 'string'  },
                          	{name : 'skipdoc', type: 'String'  },
     						{name : 'nos', type: 'int'   },
     						{name : 'wastetype', type: 'string'   },
                          	{name : 'wastedoc', type: 'String'  },
     						{name : 'method', type: 'String'  },
     						{name : 'servicemthd', type: 'String'  },
                          	{name : 'serviceschdle', type: 'String'  },
                          	{name : 'days', type: 'String'  },
                          	
     						
     											
                 ],
                 localdata: enqdata1,
                
                
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

 var cellclassname = function (row, column, value, data) {
                
            	if(data.invtrno>0){
                	return "orangeClass";
                }
            
              };
            
            $("#jqxEnquiry").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
            
                disabled:true,
                editable: true,
                altRows: true,
             
                selectionmode: 'singlecell',
                pagermode: 'default',
                
       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            
							{ text: 'Site', datafield: 'site', width: '10%' },	
						//	{ text: 'Area', datafield: 'area', width: '10%'},
							{ text: 'Skiptype', datafield: 'skiptype', width: '10%',editable:false },	
							{text: 'Skipdoc',datafield:'skipdoc',width:'25%',editable:false,hidden:true},
							{ text: 'Nos', datafield: 'nos', width: '4%'},
							{ text: 'Wastetype', datafield: 'wastetype', width: '10%' ,editable:false},	
							{text: 'Wastedoc',datafield:'wastedoc',width:'25%',editable:false,hidden:true},
							{ text: 'Method', datafield: 'method', width: '14%',cellclassname: cellclassname,columntype:'dropdownlist',
								
 								createeditor: function (row, column, editor){
 									
 		                           billmodelist = ["Sell", "Rent", "Client Owned"];
 		                         
 									editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
 								
 								},
							 	 initeditor: function (row, cellvalue, editor)
							 	 {
 		                          
									var method = $('#jqxEnquiry').jqxGrid('getcellvalue', row, "method");
									
 									editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
 									
 									 
 									
 		                        }, 
					
					},
							{ text: 'Service method', datafield: 'servicemthd', width: '20%',cellclassname: cellclassname,columntype:'dropdownlist',
						createeditor: function (row, column, editor) {
								
	                           billmodelist = ["Replacement", "Compactor"];
	                         
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
							
							},
						 	 initeditor: function (row, cellvalue, editor) {
	                          
								var servicemthd = $('#jqxEnquiry').jqxGrid('getcellvalue', row, "servicemthd");
								
								editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
								
								 
								
	                        }, 
				
				},
							
							{ text: 'Service schedule', datafield: 'serviceschdle', width: '20%',cellclassname: cellclassname,columntype:'dropdownlist',
							createeditor: function (row, column, editor) {
									
		                           billmodelist = ["Daily", "Alternative", "Weekly","Monthly","Days","On call"];
		                         
									editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
								
								},
							 	 initeditor: function (row, cellvalue, editor) {
		                          
									var serviceschdle = $('#jqxEnquiry').jqxGrid('getcellvalue', row, "serviceschdle");
									
									editor.jqxDropDownList({ autoDropDownHeight: true, source: billmodelist });
									
									 
									
		                        }, 
					
					},
							
							{ text: 'Days', datafield: 'days', width: '8%' },	
							 ]
               
            });
            $('#jqxEnquiry').on('celldoubleclick', function(event) 
            		{
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
 		      
 		      if((datafield=="skiptype"))
	    	   {
 		    	  
 		    	 getskiptype(rowBoundIndex);
 		    	 
	    	   }
 		     if((datafield=="wastetype"))
	    	   {
 		    	 
 		    	getwastetype(rowBoundIndex);
	    	   }
 		     
            			
            		});
            
            if($('#mode').val()=='view'){
                
          		 $("#jqxEnquiry").jqxGrid({ disabled: true});
              }
                 
            $("#jqxEnquiry").jqxGrid('addrow', null, {});
        });
    </script>
    <div id="jqxEnquiry"></div>
