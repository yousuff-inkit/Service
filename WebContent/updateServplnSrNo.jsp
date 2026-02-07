<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%

ClsConnection clsConnection=new ClsConnection();
Connection con=null;
try{
	int docno=0;
	String dtype;
	int trno=0;
	int val=0;
	con=clsConnection.getMyConnection();
	Statement st=con.createStatement();
	String sql="select val,doc_no,dtype from cm_serplncount";
	
	ResultSet rs=st.executeQuery(sql);
while(rs.next()){
	Statement trst=con.createStatement();
	val=rs.getInt("val");
	for(int i=1;i<=val;i++){
		String trnsql="select max(tr_no) trno,doc_no from (select tr_no,doc_no from cm_servplan where doc_no="+rs.getInt("doc_no")+" and dtype='"+rs.getString("dtype")+"' limit "+i+" ) a;";
		System.out.println(trnsql);
		ResultSet trnrs=trst.executeQuery(trnsql);
		while(trnrs.next()){
			Statement upst=con.createStatement();

			String upsql="update cm_servplan set sr_no="+i+" where tr_no="+trnrs.getInt("trno")+" ";
			System.out.println(upsql);
			int a=upst.executeUpdate(upsql);
		}
	}

	
}
	
}catch(Exception e){
	e.printStackTrace();
}


%>