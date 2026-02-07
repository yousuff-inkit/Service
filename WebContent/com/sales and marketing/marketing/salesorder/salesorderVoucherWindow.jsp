<script type="text/javascript">
	

 	function printHeaderVoucher() {
		var url=document.URL;
		var reurl=url.split("com/");
	    //$("#docno").prop("disabled", false);
		var win=window.open(reurl[0]+"com/sales/marketing/salesorder/printsalesorder?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		win.focus();
	} 
	 	  
	function funPrint(id) {
		$("#docno").attr("disabled", false);
		$("#masterdoc_no").attr("disabled", false);
		$("#formdetailcode").attr("disabled", false);
				
		var url=document.URL;
        var reurl=url.split("com/");
		var win= window.open(reurl[0]+"com/sales/marketing/salesorder/printsalesorder?docno="+document.getElementById("masterdoc_no").value+"&id="+id,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		win.focus();
  	}
 	
 	function hidedat(){
 		
 		var contrtype=document.getElementById("hidradio").value;
 		
 		
 			 $("#btnamc").show();
 			 $("#btnsjobamt").show();
 		
 	}

</script>
<body>
<div id="search">
<br/><br/><br/><br/><br/><br/>
<table width="100%">
  <tr>
    <td align="center"><input type="button" name="btnvoucherhead" id="btnsjobamt" class="myButton" value="Print(Without Image)"  onclick="funPrint(0);"></td>
    <td align="center"><input type="button" name="btncheque" id="btnamc" class="myButton" value="Print (With Image)"  onclick="funPrint(1);"></td> 
     </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>