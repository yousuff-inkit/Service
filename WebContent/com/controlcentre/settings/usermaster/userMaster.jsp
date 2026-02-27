<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style type="text/css">
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    overflow-y: auto;
    font-family: 'Segoe UI', sans-serif;
    background: #eef1f5;
    color: #2d3748;
}

/* Thin modern scrollbar */
body::-webkit-scrollbar {
    width: 8px;
}

body::-webkit-scrollbar-thumb {
    background: #cbd5e1;
    border-radius: 10px;
}

body::-webkit-scrollbar-thumb:hover {
    background: #94a3b8;
}
#mainBG {
    background: #ffffff;
    border-radius: 14px;
    padding: 18px 25px 25px 25px; /* Reduced top padding */
    margin: 20px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.06);
}

/* Remove unwanted gap after header include */
#mainBG > br {
    display: none;
}

.page-title {
    font-size: 22px;
    font-weight: 600;
    margin: 10px 0 15px 0; /* Reduced spacing */
    color: #2d3748;
}


.toolbar {
    display: flex;
    gap: 10px;
    margin-bottom: 18px;
}

.toolbar button {
    background: #f1f3f6;
    border: none;
    padding: 7px 16px;
    border-radius: 20px;
    font-size: 13px;
    cursor: pointer;
    transition: 0.2s ease;
}

.toolbar button:hover {
    background: #e2e6ea;
}


.section-card {
    background: #f5f7fa;
    border-radius: 14px;
    padding: 18px;
    margin-bottom: 20px;
}

.section-title {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 18px;
    padding-left: 10px;
    border-left: 4px solid #1e88e5;
    color: #2d3748;
}

.two-column {
    display: flex;
    gap: 20px;
}

.section-half {
    flex: 1;
}

.form-row {
    display: grid;
    grid-template-columns: 140px 1fr 140px 1fr;
    gap: 15px;
    margin-bottom: 14px;
    align-items: center;
}

.form-row.single {
    grid-template-columns: 140px 1fr;
}


input[type="text"],
select {
    height: 34px;
    border: 1px solid #d8dee9;
    border-radius: 8px;
    padding: 6px 12px;
    background: #ffffff;
    font-size: 14px;
    box-sizing: border-box;
    transition: 0.2s ease;
}

input[type="text"]:focus,
select:focus {
    border-color: #1e88e5;
    outline: none;
    box-shadow: 0 0 0 2px rgba(30,136,229,0.15);
}

label {
    font-weight: 600;
    font-size: 13px;
    color: #4a5568;
}

.table-section {
    margin-top: 25px;
}

.table-title {
    font-weight: 600;
    margin-bottom: 10px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #ffffff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #e3e8ef;
}

.cr-table th {
    background: #f1f3f6;
    padding: 10px;
    font-size: 13px;
    text-align: left;
    font-weight: 600;
}

.cr-table td {
    padding: 10px;
    border-bottom: 1px solid #edf2f7;
    font-size: 13px;
}

.cr-table tr:last-child td {
    border-bottom: none;
}


input[type="checkbox"] {
    transform: scale(1.05);
    margin-right: 6px;
}

@media (max-width: 1024px) {

    .two-column {
        flex-direction: column;
    }

    .form-row {
        grid-template-columns: 140px 1fr;
    }

}
</style>
<script type="text/javascript">
      $(document).ready(function () { 
    	  $("#jqxUserMasterDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
    	  $('#roleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'User Role Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    	  $('#roleDetailsWindow').jqxWindow('close');
    	  
    	  $('#txtpasswordconfirm').on('keyup', function () {
        	 // alert($(this).val() == $('#txtuserpassword').val());
        	    if ($(this).val() == $('#txtuserpassword').val()) {
        	    	//alert("in");
        	        $('#message').html('Matching').css('color', 'green');
        	    } else $('#message').html('Not Matching').css('color', 'red');
        	});
    	   
    	       
    	  $('#txtbrole').dblclick(function(){
  	  	    $('#roleDetailsWindow').jqxWindow('open');
  	   
  	  	roleSearchContent('userRoleSearchGrid.jsp?', $('#roleDetailsWindow')); 
         
    	  
    	  });
      });
     
      
      
      
      function roleSearchContent(url) {
          $('#roleDetailsWindow').jqxWindow('open');
       $.get(url).done(function (data) {
       $('#roleDetailsWindow').jqxWindow('setContent', data);
       $('#roleDetailsWindow').jqxWindow('bringToFront');
      }); 
       
      }
     
		function funReadOnly(){
			$('#frmUserMaster input').attr('readonly', true );
			$('#frmUserMaster select').attr('disabled', true );
			$('#jqxUserMasterDate').jqxDateTimeInput({ disabled: true});
			
			
		}
		function funFocus(){
			$('#jqxUserMasterDate').jqxDateTimeInput('focus'); 
		}
		function funRemoveReadOnly(){
			$('#frmUserMaster input').attr('readonly', false );
			$('#frmUserMaster select').attr('disabled', false );
			$('#jqxUserMasterDate').jqxDateTimeInput({ disabled: false});
			$('#docno').attr('readonly', true);
			$('#levels').val(0);
			$('#txtbrole').attr('readonly', true);
			if($('#mode').val()=="A")
				{
				
				 $('#jqxUserMasterDate').val(new Date());
			 $("#userMasterDiv").load("userMasterGrid.jsp");
			  
			
				}
			
			if ($("#mode").val() == "E") {
				if(document.getElementById("permissionval").value==1)
					{
					
				/*     $("#jqxUserMaster").jqxGrid('clear');	 */
				/* 	 var docnumber=document.getElementById("docno").value;
					 $("#userMasterDiv").load("userMasterGrid.jsp?docno="+docnumber);  */
			    	   $("#jqxUserMaster").jqxGrid({ disabled: false});   
			    	 /*   $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
					 $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); */ 
					}
			}
			
			if ($("#mode").val() == "D") {
				
				
				$('#jqxUserMasterDate').jqxDateTimeInput({ disabled: false});
			}
			
			 getLang();
			
		}

		function getLang() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					items = items.split('####');
					var langItems = items[0].split(",");
					var optionslang = '';
					for (var i = 0; i < langItems.length; i++) {
						optionslang += '<option value="' + langItems[i] + '">'
								+ langItems[i] + '</option>';
					}
					
					$("select#cmblanguage").html(optionslang);
					
					if ($('#langval').val()!="") {
						
					
						var aa=$('#langval').val().trim();
						
					    $('#cmblanguage').val(aa) ;
			            
			            }
			
					
				} else {
				}
			}
			x.open("GET", "getLang.jsp", true);
			x.send();
		}
		
		
		function funSearchLoad()
		{
		 changeContent('masterSearchuser.jsp'); 
		}
		
		
		function checkUserid() {
		
			var userid=document.getElementById("txtuser").value;
			
			  var masterdoc=document.getElementById("docno").value;
		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					
					 if(parseInt(items)>0)
				 		{
						 document.getElementById("useridchk").value=1;				 		
				 			document.getElementById("errormsg").innerText="User ID Already Exists";
				 			return  false;
				 			 
				 		}
				 		 else
				 			 {
				 			 document.getElementById("useridchk").value="";		
				 			document.getElementById("errormsg").innerText="";
				 			return  true;
				 			 }
				 		
				 }
			       else
				  {
			    	   
				  }
					
					
				
			}
			x.open("GET", "checkUserid.jsp?userid="+userid+"&masterdoc="+masterdoc, true);
			x.send();
		}
		
		function checkUsername() {
		
			var username=document.getElementById("txtusername").value;
			
			  var masterdocs=document.getElementById("docno").value;
		
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					
					 if(parseInt(items)>0)
				 		{
						 document.getElementById("usernamechk").value=1;		
				 			document.getElementById("errormsg").innerText="User Name Already Exists";
				 			return  false;
				 			 
				 		}
				 		 else
				 			 {
				 			 document.getElementById("usernamechk").value="";		
				 			document.getElementById("errormsg").innerText="";
				 			return  true;
				 			 }
				 		
				 }
			       else
				  {
			    	   
				  }
					
					
				
			}
			x.open("GET", "checkUsername.jsp?username="+username+"&masterdocs="+masterdocs, true);
			x.send();
		}
		
		
/* 		$(function(){
		    $('#frmUserMaster').validate({
		             rules: {
		            	 txtuser:{
		                	 required:true,maxlength:10
		                 },
		                 txtusername:{
		                	 required:true,maxlength:30
		                 },
		               
		            	 txtuserpassword:{
		                	 required:true,maxlength:100
			                 },
			             txtpasswordconfirm:{
		                	 required:true
			                 },
			                 
			                 txtusermail:"required"
		            
		             },
		             messages: {
		            	 txtuser:{
		            		 required:" *required",maxlength:"max 10 chars"
		                 },
		                 txtusername:{
		                	 required:"*required",maxlength:" max 30 chars"
		                 },
		              
		            	 txtuserpassword:{
		                	  required:" *required",maxlength:" max 100 chars"
		                  },
		                  txtpasswordconfirm:{
		                	  required:" *required"
				                 },
				                 txtusermail:" *Enter Valid Email",          
				  
		             }
		    });
		    }); */
		
		  function funNotify(){
			
			 
           var useridchk= document.getElementById("useridchk").value;
			 
			 if(parseInt(useridchk)==1)
				 {
				 
				 document.getElementById("errormsg").innerText="User ID Already Exists";
				 document.getElementById("txtuser").focus();
		 			return  0;
				 
				 }
              var usernamechk= document.getElementById("usernamechk").value;
			 
			 if(parseInt(usernamechk)==1)
				 {
				 
				 document.getElementById("errormsg").innerText="User Name Already Exists";
				 document.getElementById("txtusername").focus();
		 			return  0; 
				 
				 }
			 var levelss= document.getElementById("levels").value;
			 if(levelss=="")
				 {
				 document.getElementById("errormsg").innerText="Select Discount Level";
				 document.getElementById("levels").focus();
		 			return  0; 
				 }
			 var rolelevel= document.getElementById("txtbrole").value;
			 if(rolelevel=="")
				 {
				 document.getElementById("errormsg").innerText="Select Role";
				 document.getElementById("txtbrole").focus();
		 			return  0; 
				 }
			 
			 
			 if($('#txtuserpassword').val()!=$('#txtpasswordconfirm').val())
				 {
				 
				 document.getElementById("errormsg").innerText="Password Is Not Matching";
		 			return  0; 
				 }
			
			 
			 
			    if($('#cmpermission').val()==1)

		    	   {	   			    
			   var z=0;
		       var rows = $("#jqxUserMaster").jqxGrid('getrows');                    
		           
		       var selectedRecords = new Array();
		       var selectedrows=$("#jqxUserMaster").jqxGrid('selectedrowindexes');
		      
			  if(selectedrows.length==0){
			   $.messager.alert('Warning','Select Branch & Company.');
			   return false;
			  }
		  
		      $('#existusermaster').val(selectedrows.length);
		    /*   alert("Length = "+$('#existusermaster').val()); */
		      for (var i = 0; i < rows.length; i++) {
		      for(var j=0;j<selectedrows.length;j++){
		       if(selectedrows[j]==i){
		        
		        newTextBox = $(document.createElement("input"))
		           .attr("type", "dil")
		           .attr("id", "test"+z)
		           .attr("name", "test"+z)
		           .attr("hidden","true");
		        
		       newTextBox.val(rows[i].brhid+"::"+rows[i].compid);
		     /*   alert("newTextBox.val() = "+newTextBox.val()); */
		       newTextBox.appendTo('form');
		       z++;
		       }
		      }
		   }
		    
		    	   }
		
		    
			    return 1;
		} 
		  
	
	       function getURole(event){
	              var x= event.keyCode;
	              if(x==114){
	               roleSearchContent('userRoleSearchGrid.jsp');
	              }
	              else{
	               }
	              }
	     function fungriddis()
	     {
	       
	       if($('#cmpermission').val()==1)

	    	   {
	    	   $("#jqxUserMaster").jqxGrid({ disabled: false});   
	    	   
	    	   
	    	   $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
	    	   
	    	   }
	       else
	    	   {
	    	   $("#jqxUserMaster").jqxGrid({ disabled: true}); 
	    	   $('#jqxUserMaster').jqxGrid({ selectionmode: 'checkbox'}); 
	    	   }
	     }
	     
	   
	     function checkvals()
	     {
	     
	 
	   if($('#permissionval').val()!="")
	  {
	  
	 
	  $('#cmpermission').val($('#permissionval').val());
	  }
	   
	   if($('#hidelevels').val()!="")
	  {
	 
	  $('#levels').val($('#hidelevels').val());
	  }
	     
	   
	   
	   
	   
	     }

	     
		function setValues() {
			if($('#hidjqxUserMasterDate').val()){
				$("#jqxUserMasterDate").jqxDateTimeInput('val', $('#hidjqxUserMasterDate').val());
			}
			var docnumber=document.getElementById("docno").value;
			
			if(parseInt(docnumber)>0)
				{ 
				
		
				 $("#userMasterDiv").load("userMasterGrid.jsp?docno="+docnumber);
			}  
			
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
		    }
			
			
			 getLang();
	        checkvals();
			document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			funSetlabel();
			
		
			
		}

		
  </script>
</head>
<body onload="setValues();getLang();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmUserMaster" action="saveUserMaster" autocomplete="off">

<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="section-card">

    <!-- Title + Doc No -->
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:18px;">
        <div class="section-title" style="margin:0;">User Master Info</div>

        <div style="display:flex; align-items:center; gap:10px;">
            <label style="margin:0;">Doc No</label>
            <input type="text"
                   id="docno"
                   name="docno"
                   value='<s:property value="docno"/>'
                   tabindex="-1"
                   style="width:120px;">
        </div>
    </div>

    <!-- Date -->
    <div class="form-row single">
        <label>Date</label>
        <div>
            <div id='jqxUserMasterDate'
                 name='jqxUserMasterDate'
                 value='<s:property value="jqxUserMasterDate"/>'></div>
            <input type="hidden"
                   id="hidjqxUserMasterDate"
                   name="hidjqxUserMasterDate"
                   value='<s:property value="hidjqxUserMasterDate"/>'/>
        </div>
    </div>

    <!-- User ID + Name -->
    <div class="form-row">
        <label>User ID</label>
        <input type="text"
               id="txtuser"
               name="txtuser"
               placeholder="Enter user ID"
               value='<s:property value="txtuser"/>'
               onblur="checkUserid()">

        <label>User Name</label>
        <input type="text"
               id="txtusername"
               name="txtusername"
               placeholder="Enter user Name"
               value='<s:property value="txtusername"/>'
               onblur="checkUsername()">
    </div>

    <!-- Role + Language -->
    <div class="form-row">
        <label>Role</label>
        <div>
            <input type="text"
                   id="txtbrole"
                   name="txtbrole"
                   placeholder="Press F3 to Search"
                   value='<s:property value="txtbrole"/>'
                   onkeydown="getURole(event);"
                   style="width:220px;">
            <input type="hidden"
                   id="txtroleid"
                   name="txtroleid"
                   value='<s:property value="txtroleid"/>'/>
        </div>

        <label>Language</label>
        <div>
            <select id="cmblanguage"
                    name="cmblanguage"
                    style="width:160px;">
            </select>
            <input type="hidden"
                   id="hidcmblanguage"
                   name="hidcmblanguage"
                   value='<s:property value="hidcmblanguage"/>'/>
        </div>
    </div>

    <!-- Email + Permission -->
    <div class="form-row">
        <label>Email</label>
        <input type="text"
               id="txtusermail"
               name="txtusermail"
               placeholder="Email"
               value='<s:property value="txtusermail"/>'>

        <label>Permission</label>
        <div>
            <select id="text"
                    name="cmpermission"
                    onchange="fungriddis()"
                    style="width:160px;">
                <option value="0">All Branch</option>
                <option value="1">Selected Branch</option>
            </select>
            <input type="hidden"
                   id="hidcmpermission"
                   name="hidcmpermission"
                   value='<s:property value="hidcmpermission"/>'/>
        </div>
    </div>

    <!-- Mail Settings -->
    <div class="form-row">
        <label>E-mail Password</label>
        <input type="text"
               id="txtmailpswd"
               name="txtmailpswd"
               placeholder="Email Password"
               value='<s:property value="txtmailpswd"/>'>

        <label>Signature</label>
        <input type="text"
               id="txtmailsign"
               name="txtmailsign"
               placeholder="Email Signature"
               value='<s:property value="txtmailsign"/>'>
    </div>

    <div class="form-row">
        <label>E-mail Host</label>
        <input type="text"
               id="txtmailhost"
               name="txtmailhost"
               placeholder="Email Host"
               value='<s:property value="txtmailhost"/>'>

        <label>E-mail Port</label>
        <input type="text"
               id="txtmailport"
               name="txtmailport"
               placeholder="Email Port"
               value='<s:property value="txtmailport"/>'>
    </div>

    <!-- Password -->
    <div class="form-row">
        <label>Password</label>
        <input type="text"
               id="txtuserpassword"
               name="txtuserpassword"
               placeholder="Enter Password"
               value='<s:property value="txtuserpassword"/>'>

        <label>Confirm</label>
        <div>
            <input type="text"
                   id="txtpasswordconfirm"
                   name="txtpasswordconfirm"
                   placeholder="Enter Confirm Password"
                   value='<s:property value="txtpasswordconfirm"/>'
                   style="width:180px;">
            <span style="font-weight:bold;" id="message"></span>
        </div>
    </div>

</div>

<!-- GRID -->
<div class="section-card">
    <div id="userMasterDiv">
        <jsp:include page="userMasterGrid.jsp"></jsp:include>
    </div>
</div>

<!-- Hidden Fields -->
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
<input type="hidden" id="useridchk" name="useridchk" value='<s:property value="useridchk"/>'/>
<input type="hidden" id="usernamechk" name="usernamechk" value='<s:property value="usernamechk"/>'/>
<input type="hidden" id="langval" name="langval" value='<s:property value="langval"/>'/>
<input type="hidden" id="levels" name="levels" value='<s:property value="levels"/>'/>
<input type="hidden" id="permissionval" name="permissionval" value='<s:property value="permissionval"/>'/>
<input type="hidden" id="existusermaster" name="existusermaster" value='<s:property value="existusermaster"/>'/>
<input type="hidden" id="hidelevels" name="hidelevels" value='<s:property value="hidelevels"/>'/>

</form>

<div id="roleDetailsWindow">
 <div></div>
</div>

</div>
</body>
</html>