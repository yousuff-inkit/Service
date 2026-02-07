<%@page import="java.util.ArrayList"%>
<%@page import ="com.connection.ClsConnection"%>
<%@page import ="java.sql.*" %>
<%@page import="javax.sql.*" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.ArrayList" %>
<%
 	Connection conn=null,connms=null;
	try{
		ClsConnection objconn= new ClsConnection();
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);

		ArrayList<String> stkissue= new ArrayList<String>();
		String updateString="",insString="";
		Statement stmtaptran=null,stmtupd=null,stmtins=null;
		ResultSet rsaptran =null;

		// left join with stock as actual stock qty can be 0 , TRNO MANUL INSERTED IN TABLE
		String sqlselect=" insert into my_prddin(psrno, tr_no, date, dtype,  fr, unitid, specno, op_qty, out_qty, rsv_qty, del_qty, foc, foc_out, prdid, locid, brhid, sr_no, cost_price, unit_price, pack, exp_date, batch_no, invno, pstatus, error_msg, refstockid, outdocno) "
				+" select p.psrno,25282,20231011,'PHK',1,mUNIT,P.PSRNO, curstk-coalesce(actual,0),0,0,0,0,0,P.PSRNO,1,1,P.SL,COST_PRICE,0,0,NULL,'',0,0,'',0,0 from aa_aphkstk p left join  (SELECT psrno,SUM(OP_QTY-OUT_QTY-RSV_QTY) actual,COST_PRICE FROM my_prddin  where psrno is not null  GROUP BY psrno having actual>0) o on p.psrno=o.psrno " 
				+" LEFT JOIN MY_MAIN M ON M.PSRNO=P.PSRNO  where p.psrno is not null  and curstk>coalesce(actual,0) and p.inserted=0 ; ";
		System.out.println("1======"+sqlselect);
		Statement stmtrecpt= conn.createStatement();
		int updcnt = stmtrecpt.executeUpdate(sqlselect);
	
		//UPDATE AS INSERTED USING TRNO IN PRDDIN
		String sqlupdate="update aa_aphkstk p INNER join  MY_PRDDIN o on p.psrno=o.psrno AND O.TR_NO=25282 AND O.DTYPE='PHK' set p.inserted=1 where  p.inserted=0  ;";
		System.out.println("2======"+sqlupdate);
		stmtrecpt.executeUpdate(sqlupdate);
		
		sqlupdate=" UPDATE aa_aphkstk p INNER join  (SELECT psrno,SUM(OP_QTY-OUT_QTY-RSV_QTY) actual,COST_PRICE FROM my_prddin   GROUP BY psrno having actual>0) o on p.psrno=o.psrno  SET  p.inserted=2   where p.psrno is not null  and curstk=coalesce(actual,0) and p.inserted=0 ;";
		System.out.println("21======"+sqlupdate);
		stmtrecpt.executeUpdate(sqlupdate);
		
		
		sqlselect = " select p.psrno,curstk,round(coalesce(actual,0)-curstk,2) toissue from aa_aphkstk p left join "
		 + " (SELECT psrno,round(SUM(OP_QTY-OUT_QTY-RSV_QTY),2) actual,COST_PRICE FROM my_prddin  where OP_QTY-OUT_QTY-RSV_QTY>0  GROUP BY psrno having actual!=0) o on p.psrno=o.psrno "
		 + " LEFT JOIN MY_MAIN M ON M.PSRNO=P.PSRNO  where p.psrno is not null  and curstk<coalesce(actual,0)  and p.inserted=0  " ;
		System.out.println("3 ======"+sqlselect);
		ResultSet rs=stmtrecpt.executeQuery(sqlselect);
		while(rs.next()){
			System.out.println(rs.getString("psrno")+"::"+rs.getString("curstk")+"::"+rs.getString("toissue"));
			stkissue.add(rs.getString("psrno")+"::"+rs.getString("curstk")+"::"+rs.getString("toissue"));
		}
		System.out.println("4 ======"+stkissue);
		int psrno= 0,stockid=0 ;
		double curstk= 0.0, tottoissue =0.0 , avstk=0.0;
		String issueitem[];
		stmtaptran=conn.createStatement();
		for(int i=0;i<stkissue.size();i++){
			issueitem = stkissue.get(i).split("::");
			psrno= Integer.parseInt(issueitem[0]) ;
			curstk= Double.parseDouble(issueitem[1]);
			tottoissue = Double.parseDouble(issueitem[2]);
			
			
				
				sqlselect = " select stockid,op_qty-out_qty-RSV_QTY avstk from my_prddin where psrno="+psrno+" and OP_QTY-OUT_QTY-RSV_QTY!=0 order by stockid " ;
				System.out.println(" 5 ======"+sqlselect);
				ResultSet rsprddin=stmtaptran.executeQuery(sqlselect);
				while(rsprddin.next()){
							stockid=rsprddin.getInt("stockid");
							avstk=rsprddin.getDouble("avstk")>tottoissue?tottoissue:rsprddin.getDouble("avstk"); 
							
							
								sqlupdate=" update my_prddin set out_qty= out_qty+" +avstk+ " where stockid = "+stockid;
								System.out.println(" 6 ======"+sqlupdate);
								stmtrecpt.executeUpdate(sqlupdate);
								
								insString= " insert into my_prddout(SR_NO,  TR_NO, dtype, specid, psrno, prdid, stockid, qty, rsv_qty, del_qty, foc, date, rdocno, brhid, locid, unit_price, cost_price, edate, out_qty, rrowno) "
										 + " select 1, 25282, 'PHK',specno,psrno,prdid,stockid, "+avstk+" , 0,0,0,curdate(),1, 1, 1, 0,cost_price,now(),0,0 from my_prddin where stockid= "+stockid ;
								System.out.println(" 7 ======"+insString);
								stmtrecpt.execute(insString);
	
								tottoissue=tottoissue-avstk;
							if(tottoissue==0){
								sqlupdate=" update aa_aphkstk set INSERTED= 1 where PSRNO = "+psrno;
								System.out.println(" 8 ======"+sqlupdate);
								stmtrecpt.executeUpdate(sqlupdate);
								break ;
							}
						}
			
		}
/*
		select stockid,op_qty-out_qty from my_prddin where psrno=33 and OP_QTY-OUT_QTY!=0  ;
		update my_prddin set out_qty= 404 where stockid =9537 ;
		insert into my_prddout(SR_NO,  TR_NO, dtype, specid, psrno, prdid, stockid, qty, rsv_qty, del_qty, foc, date, rdocno, brhid, locid, unit_price, cost_price,
		 edate, out_qty, rrowno);

		select 1,25282,'PHK',specno,psrno,prdid,stockid,404 , 0,0,0,curdate(),1, 1, 1, 0,cost_price,now(),0 from my_prddin where stockid=9537;

		select * from aa_aphkstk where psrno=33;
	*/	
		conn.commit();
	}
	catch(Exception e){
		e.printStackTrace();	
	}
	finally{
		conn.close();
	}
%>