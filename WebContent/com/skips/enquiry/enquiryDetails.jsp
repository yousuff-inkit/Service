<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.skips.enquiry.ClsEnquiryDAO" %>


 <%
 			ClsEnquiryDAO DAO= new ClsEnquiryDAO();
            	String enqrdocno = request.getParameter("enqrdocno")==null?"0":request.getParameter("enqrdocno").trim();
            //System.out.println("---------"+enqrdocno);
 %> 
<script type="text/javascript">

           	  
           	var temp1='<%=enqrdocno%>';
            var hide;
            var enqdata1;
            if(temp1>0)
          	 {
            	   enqdata1= '<%=DAO.searchrelode(enqrdocno,session)%>'; 
            	 
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
                          	{name : 'skipdoc', type: 'string'  },
     						{name : 'nos', type: 'string'   },
     						{name : 'wastetype', type: 'string'   },
                          	{name : 'wastedoc', type: 'string'  },
     						{name : 'method', type: 'String'  },
                          	{name : 'srno', type: 'string'  },
     						{name : 'servmethod', type: 'String'  },
                          	{name : 'servsrno', type: 'string'  },
                          	{name : 'scheduletype', type: 'String'  },
                          	{name : 'schedulesrno', type: 'string'  },
                          	{name : 'scheduledays', type: 'string'  },
                          	{name : 'spec', type: 'String'  },
                          	{name : 'sepcid', type: 'string'  },
                          	{name : 'collection', type: 'String'  },
                          	{name : 'collectionsrno', type: 'string'  },
                          	{name : 'rowno', type: 'string'  },
	                        {name : 'siteid', type: 'String'  },     


                          	
     						
     											
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
                        	{ text: 'siteid',datafield:'siteid',width:'5%',editable:false,hidden:true},
						//	{ text: 'Area', datafield: 'area', width: '10%'},
							{ text: 'Waste Type', datafield: 'wastetype', width: '10%' ,editable:false},	
							{text: 'Wastedoc',datafield:'wastedoc',width:'25%',editable:false,hidden:true},
							{ text: 'Skip Size', datafield: 'skiptype', width: '10%',editable:false },	
							{text: 'Skipdoc',datafield:'skipdoc',width:'25%',editable:false,hidden:true},
							{ text: 'Spec', datafield: 'spec', width: '10%'},
							{ text: 'sepcid', datafield: 'sepcid', width: '4%',hidden:true},
							{text: 'Method',datafield:'method',width:'10%',editable:false,hidden:true},
							{text: 'Ownership',datafield:'servmethod',width:'10%',editable:false},							
							{ text: 'Qty', datafield: 'nos', width: '10%',
								 validation: function (cell, value) {
						             if(value % 1 !== 0)  
						             {
						                 return { result: false, message: "Qty should contain only numbers" };   
						             }
						             return true;
						          }},
							{text: 'Service Term',datafield:'scheduletype',editable:false},							
							{text: 'SR No',datafield:'srno',width:'25%',editable:false,hidden:true},
							{text: 'Serv SR No',datafield:'servsrno',width:'25%',editable:false,hidden:true},							
							{text: 'Schedule SR No',datafield:'schedulesrno',width:'25%',editable:false,hidden:true},							
							{ text: 'No of Visit', datafield: 'scheduledays', width: '10%',
								 validation: function (cell, value) {
						             if(value % 1 !== 0)  
						             {
						                 return { result: false, message: "No of Visit should contain only numbers" };   
						             }
						             return true;
						          }
							},
							{ text: 'Collection', datafield: 'collection', width: '10%',editable:false},
							{ text: 'collectionsrno', datafield: 'collectionsrno', width: '10%',editable:false,hidden:true },	
							{ text: 'rowno', datafield: 'rowno', width: '10%',editable:false,hidden:true},	


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
 		    if((datafield=="method"))
	    	   {
		    	 
		    	getmethod(rowBoundIndex);
	    	   }
 		   if((datafield=="servmethod"))
    	   {
		    	 
		    	getservby(rowBoundIndex);
    	   }
 		  if((datafield=="scheduletype"))
   	   {
	    	 
	    	getschedule(rowBoundIndex);
   	   }
 		 if((datafield=="collection"))
 	   	   {
 		    	 
 		    	getcollection(rowBoundIndex);
 	   	   }
 		 if((datafield=="spec"))
	   	   {
		    	 
		    	getspec(rowBoundIndex);
	   	   }
 		 if((datafield=="site")) {
	    		getsite(rowBoundIndex);  
 	    }
            		 });
            
            if($('#mode').val()=='view'){
                
          		 $("#jqxEnquiry").jqxGrid({ disabled: true});
              }
                 
           $("#jqxEnquiry").jqxGrid('addrow', null, {});
            
        
           
            
           $('#window').jqxWindow('close');
           
        	
        
            
        });
    </script>
    <div id="jqxEnquiry"></div>
