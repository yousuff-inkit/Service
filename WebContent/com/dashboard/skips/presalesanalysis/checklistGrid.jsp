<%@page import="com.dashboard.skips.presalesanalysis.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>  
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsPresalesanalysisDAO DAO= new ClsPresalesanalysisDAO();  
 %>
 <%
 String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim().toString();
 String id=request.getParameter("id")==null?"0":request.getParameter("id").trim().toString();
 %>
 <style type="text/css">
.redClass {
	background-color: #FFEBEB;
}

.yellowClass {
	background-color: #FFFF00;
}

.orangeClass {
	background-color: #FFEBC2;
}
</style>
    <script type="text/javascript">
    var sitedata;
    var attachdesc;
    $(document).ready(function () { 
    		sitedata='<%=DAO.checklistData(session,docno,id)%>';      
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'checksrno' , type: 'number' },
     						{name : 'desc1', type: 'String'  },
                          	{name : 'remarks', type: 'String'  },
                          	{name : 'mandatory', type: 'String'  },
                          	{name : 'chk', type: 'bool'  },  
                        	{name : 'attach', type: 'String'  },
                       	    {name : 'upload',type:'string'}, 
                       	    {name : 'path',type:'String'},
                       	 	{name : 'qotno' , type: 'number' },  
                       	    {name : 'rowno' , type: 'number' },    
                          	],
                 localdata: sitedata,
                
                
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
          		 if (data.mandatory==1) {
                      return "orangeClass";
                  };
               };
            $("#jqxChecklistGrid").jqxGrid(
            {
                width: '100%',
                height: 220,
                source: dataAdapter,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',       
                sortable: true,
                editable:true,
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname:cellclassname,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Description', datafield: 'desc1',editable:false,cellclassname:cellclassname},  
					{ text: 'Remarks', datafield: 'remarks', width: '35%',cellclassname:cellclassname },
					{ text: 'rowno',datafield:'rowno',width:'5%',editable:false,hidden:true},     
					{ text: 'qotno',datafield:'qotno',width:'5%',editable:false,hidden:true},  
					{ text: 'checksrno',datafield:'checksrno',width:'25%',editable:false,hidden:true}, 
					{ text: 'mandatory',datafield:'mandatory',width:'25%',editable:false,hidden:true},
					{ text: '', datafield: 'chk', columntype: 'checkbox',width:'5%',cellclassname:cellclassname},  
					{ text: 'path',datafield:'path',hidden:true},  
					{ text: 'Attach', width:'20%', columntype: 'custom',datafield:'upload', cellbeginedit: function (row) {
					    var attach=$('#jqxChecklistGrid').jqxGrid('getcellvalue', row, "upload"); 
					    var qotno=$('#jqxChecklistGrid').jqxGrid('getcellvalue', row, "qotno");
					    if ((attach=="0" || attach=="") && parseInt(qotno)>0)  
					     {
					    	//alert("Inside");
					          return true;
					     }
					    else{
					    	return false;
					    }
					    },
					    cellsrenderer: function (row, column, value) {
					        if (value == "0") {    
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
					    	var qotno=$('#jqxChecklistGrid').jqxGrid('getcellvalue', row, "qotno");
					        if (parseInt(qotno)>0)  
					         {
					              return true;
					         }else{
					        	return false;   
					        }
					        },
					       
					        createeditor: function (row, cellvalue, editor, cellText, width, height) {
					            // construct the editor. 
					             var rowno = $('#jqxChecklistGrid').jqxGrid('getcellvalue', row, 'rowno');  
					             attachdesc = $('#jqxChecklistGrid').jqxGrid('getcellvalue', row, 'desc1');       
					             console.log(attachdesc+"=="+rowno); 
					             editor.html('<input type="button" class="myButton" onClick="return fileUpload('+rowno+');"  width="5" value="Attach"/>'); 
					        }}
					]
            });
            $('.load-wrapp').hide();   
            $('#jqxChecklistGrid').on('celldoubleclick', function (event) { 
		            	var rowBoundIndex = event.args.rowindex;
		            	var datafield = event.args.datafield;
		 		        if((datafield=="upload")) {    
		 		        	var path=$('#jqxChecklistGrid').jqxGrid('getcellvalue', rowBoundIndex, "path");
		 		        	if(typeof(path)!="undefined" && typeof(path)!="NaN" && path!="0" && path!="" && path!=null){
		 		        		SaveToDisk($('#jqxChecklistGrid').jqxGrid('getcellvalue', rowBoundIndex, "path"),$('#jqxChecklistGrid').jqxGrid('getcellvalue', rowBoundIndex, "upload"));
		 		        	}
			    	    }
            });
    });    
    function ajaxFileUpload(rowno) {
    	console.log("IN AJAX FILE UPLOAD");
  	 if($('input[type=file]').val()==""){
  		Swal.fire({
  			icon: 'warning',
				title: 'Warning',
				text: 'Please Choose a File'   
			});
  		 return false;
  	 }
  	 var formdetailcode="PSM";  
        $.ajaxFileUpload  
        (  
            {
                url:'fileUploadPresales.action?formdetailcode='+formdetailcode+'&doc='+document.getElementById("enqdocno").value+'&srno='+rowno+'&cldocno='+$("#cldocno").val()+'&brhid='+$("#brhid1").val()+'&attachdesc='+attachdesc,       
               
                secureuri:false,//false  
                fileElementId:'file',//id  <input type="file" id="file" name="file" />  
                dataType: 'json',// json  
                success: function (data, status)  //  
                {  
                	console.log(data.message);
                	console.log(status);
              	  if(status=="success"){
                  		Swal.fire({
                  			icon: 'success',
          					title: 'Success',
          					text: 'Successfully Attached'  
          				});
              		  var qotno=$('#qottrno').val();      
              		  $('#chklistDiv').load('checklistGrid.jsp?id=1&docno='+qotno);    
              	  }
                    //alert(data.message);//jsonmessage,messagestruts2  
                    // document.getElementById("savemsg").innerText="";
                    //$("#testImg").attr("src",data.message);  
                    if(typeof(data.error) != 'undefined')  
                    {  
                        if(data.error != '')  
                        {  
                        	console.log(data.error);  
                        }else  
                        {  
                        	console.log(data.message);  
                        }  
                    }  
                },  
                error: function (data, status, e)   
                {  
                	console.log(e);    
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
		   //fileName='';  
		   var host = window.location.origin;
		   //alert("host="+host);
		  
		   var splt = fileURL.split("webapps"); 
		  //alert("after split="+splt[1]);
		   var repl = splt[1].replace( /;/g, "/");
		   //alert("repl"+repl);
		   //alert("after replace===="+repl);  
		   fileURL=host+repl;
		   //alert("fileURL===="+fileURL);
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
    <div id="jqxChecklistGrid"></div>       
