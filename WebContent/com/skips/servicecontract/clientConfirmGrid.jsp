<%@page import="com.skips.servicecontract.ClsServiceContractDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsServiceContractDAO DAO= new ClsServiceContractDAO();   
 %>
 <%
 String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno").trim().toString(); 
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());
 String revisionno=request.getParameter("revisionno")==null || request.getParameter("revisionno")==""?"0":request.getParameter("revisionno").trim().toString(); 
 %> 
    <script type="text/javascript">
    var ccdata;  
    var id='<%=id%>';
    $(document).ready(function () { 
    	
    	ccdata='<%=DAO.clientConfirmData(session,trno,id,revisionno)%>';     
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'date' , type: 'Date' },
     						{name : 'pono', type: 'String'  },
                          	{name : 'validupto', type: 'Date'  },
                          	{name : 'amount', type: 'number'  },
                          	{name : 'description', type: 'String'  },
                          	{name : 'rowno', type: 'String'  },
                        	{name : 'qty', type: 'number'  },
                        	{name : 'attach', type: 'String'  },
                       	    {name : 'upload',type:'string'}, 
                       	    {name : 'path',type:'String'}
                          	],
                 localdata: ccdata,
                
                
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
            $("#jqxclientconfirmGrid").jqxGrid(
            {
                width: '100%',
                height: 170,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                sortable: true,
                editable:true,
                filterable: true, 
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                //Add row method
	            handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxclientconfirmGrid').jqxGrid('getselectedcell');
    				if (cell != undefined && cell.datafield == 'description' ) {    
                      var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                      if (key == 13 || key == 9) {
	                      	$("#jqxclientconfirmGrid").jqxGrid('addrow', null, {});	 
                      	    return true;
                      }     
                  }
                },
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Date', datafield: 'date',width:'10%',cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput'},  
					{ text: 'PO No',datafield:'pono',width:'10%'},
					{ text: 'Qty',datafield:'qty',width:'10%'},  
					{ text: 'Value', datafield: 'amount', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right' },
					{ text: 'Valid Upto', datafield: 'validupto', width: '10%',cellsformat:'dd.MM.yyyy', columntype: 'datetimeinput'},
					{ text: 'Description',datafield:'description'},
					{ text: 'rowno',datafield:'rowno',hidden:true}, 
					{ text: 'path',datafield:'path',hidden:true},  
					{ text: 'Attach', width:'20%', columntype: 'custom',datafield:'upload', cellbeginedit: function (row) {
					    var temp=document.getElementById("mode").value;
					    var attach = $('#jqxclientconfirmGrid').jqxGrid('getcellvalue', row, "upload");
					    var rownoValue = $('#jqxclientconfirmGrid').jqxGrid('getcellvalue', row, 'rowno');
						console.log(attach+"=="+temp);      
					    if (temp=="view" && (attach=="0" || attach=="") && (typeof(rownoValue)!="undefined" && typeof(rownoValue)!="NaN" && typeof(rownoValue)!="null" && rownoValue!="" && rownoValue!="0")){
					    	  console.log("Inside");
					          return true;
					     }
					    else{
					    	console.log("Outside");
					    	  return false;
					    }
					    },
					    cellsrenderer: function (row, column, value) {
					    	console.log(value+"="+document.getElementById("mode").value);    
					        if (value == "0" && document.getElementById("mode").value=="view") {  
					            return "Select a file";
					        };
					    },
					    createeditor: function (row, cellvalue, editor, cellText, width, height) {
					        // construct the editor. '<input id="file' + row + '" name="file' + row + '" type="file" />'
					         editor.html('<input type="file" id="file" name="file"/>' );  
					    },
					    geteditorvalue: function (row, cellvalue, editor) {
					        // return the editor's value.
					        var value = $("#file").val();
					        return value.substring(value.lastIndexOf("\\") + 1, value.length);
					    }},
					    { text:'Attach',datafield:'attach',width:'10%',columntype:'custom', cellbeginedit: function (row) {
					        var temp=document.getElementById("mode").value;
					        var rownoValue = $('#jqxclientconfirmGrid').jqxGrid('getcellvalue', row, 'rowno');  
					        if (temp =="view" && (typeof(rownoValue)!="undefined" && typeof(rownoValue)!="NaN" && typeof(rownoValue)!="null" && rownoValue!="" && rownoValue!="0"))
					         {
					              return true;
					         }
					        if(temp="A"){
					        	return false;
					        }
					        },
					       
					        createeditor: function (row, cellvalue, editor, cellText, width, height) {
					            // construct the editor. 
					             var rowno = $('#jqxclientconfirmGrid').jqxGrid('getcellvalue', row, 'rowno');  
					             editor.html('<input type="button" class="myButton" onClick="return fileUpload('+rowno+');"  width="5" value="Attach"/>'); 
					        }}
					]
            });
            $('#jqxclientconfirmGrid').on('celldoubleclick', function (event) { 
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
 		        if((datafield=="upload")) {    
 		        	var path=$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowBoundIndex, "path");
 		        	if(typeof(path)!="undefined" && typeof(path)!="NaN" && path!="0" && path!="" && path!=null){
 		        		SaveToDisk($('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowBoundIndex, "path"),$('#jqxclientconfirmGrid').jqxGrid('getcellvalue', rowBoundIndex, "upload"));
 		        	}
	    	    }
             });
            $("#jqxclientconfirmGrid").on('cellendedit', function (event) {      
        	    var args = event.args;
        	    var columnDataField = event.args.datafield;
        	    var rowIndex = event.args.rowindex;
        	    var cellValue = event.args.value;
        	    var oldValue = event.args.oldvalue;         
        	    if(columnDataField=="description"){              
        	    	$('#jqxclientconfirmGrid').jqxGrid('setcellvalue', rowIndex, "description",cellValue);        
        	    }
        	});
            /* if($('#mode').val()=='view'){
          		 $("#jqxclientconfirmGrid").jqxGrid({ disabled: true});
            }else{
            	 $("#jqxclientconfirmGrid").jqxGrid({ disabled: false});
            } */  
            $("#jqxclientconfirmGrid").jqxGrid('addrow', null, {});
        });
    
    function ajaxFileUpload(rowno) {
    	console.log("IN AJAX FILE UPLOAD");
  	 if($('input[type=file]').val()==""){
  		 document.getElementById("errormsg").innerText="Please Choose a File";
  		 return false;
  	 }
  	 document.getElementById("errormsg").innerText=""; 
        $.ajaxFileUpload  
        (  
            {  
                url:'fileUploadServCont.action?formdetailcode='+document.getElementById("formdetailcode").value+'&doc='+document.getElementById("docno").value+'&srno='+rowno+'&brid='+document.getElementById("brchName").value,//  
               
                secureuri:false,//false  
                fileElementId:'file',//id  <input type="file" id="file" name="file" />  
                dataType: 'json',// json  
                success: function (data, status)  //  
                {  
              	  //alert(data.message);
              	  //alert(status);
              	  if(status=="success"){
              		  document.getElementById("savemsg").innerText="Successfully Attached";
              		  $.messager.alert('Message',"Successfully Attached");  
              		  var indexVal2 = document.getElementById("masterdoc_no").value;
              		 var txtrevise = document.getElementById("txtrevise").value;
              		  $("#clcondiv").load("clientConfirmGrid.jsp?trno="+indexVal2+"&id="+1+"&revisionno="+txtrevise);    
              	  }
                    //alert(data.message);//jsonmessage,messagestruts2  
                    // document.getElementById("savemsg").innerText="";
                    //$("#testImg").attr("src",data.message);  
                    if(typeof(data.error) != 'undefined')  
                    {  
                        if(data.error != '')  
                        {  
                       //     alert(data.error);  
                        }else  
                        {  
                     //       alert(data.message);  
                        }  
                    }  
                },  
                error: function (data, status, e)//  
                {  
                   // alert(e);  
                }  
            }  
        )  
        return false;  
    }
    
    function fileUpload(row){
    	console.log("IN FILE UPLOAD");
    	 ajaxFileUpload(row);	
    }
    
	function SaveToDisk(fileURL, fileName) {
		   //alert(fileURL);
		   var host = window.location.origin;
		   var splt = fileURL.split("webapps"); 
		   var repl = splt[1].replace( /;/g, "/");
		   //var splt = fileURL.split("WebContent"); 
		     // var splt = fileURL.split("GW_WorkSpace/"); 
                        				 //alert("splt[1]=="+splt[1])      
                        			   //  fileURL=host+"/Service/"+splt[1];
            fileURL=host+repl;      

		  //alert("after split="+splt[1]);
		  // var repl = splt[1].replace( /;/g, "/");
		   //alert("repl"+repl);
		   //alert("after replace===="+repl);  
		  // fileURL=host+repl;
		  // alert("fileURL===="+fileURL);
		    // for non-IE
		    if (!window.ActiveXObject) {
		        var save = document.createElement('a');
		        //alert(save);
		       // alert(fileURL);
		        save.href = fileURL;
		        save.target = '_blank';
		        save.download = fileName || 'unknown';
				
		        window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
		        
		        //var event = document.createEvent('Event');
		       // alert(event);
		        //event.initEvent('click', true, true);
		        //save.dispatchEvent(event);
		        //(window.URL || window.webkitURL).revokeObjectURL(save.href);
		    }

		    // for IE
		    else if ( !! window.ActiveXObject && document.execCommand)     {
		        var _window = window.open(fileURL, '_blank');
		        _window.document.close();
		        _window.document.execCommand('SaveAs', true, fileName || fileURL)
		        _window.close();
		    }
		}
    </script>
    <div id="jqxclientconfirmGrid"></div>  
