<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String saleno = request.getParameter("saleno");
    String pcode = request.getParameter("pcode");
    String scode = request.getParameter("scode");
    String saledate = request.getParameter("saledate");
    String amount = request.getParameter("amount");

    Connection conn = null;
    Statement stmt = null;

    try {
        conn = Util.getConnection();
        stmt = conn.createStatement();
        String sql =
                "INSERT INTO tbl_salelist_01 " +
                        "VALUES("+ saleno +"," +
                        "'" + pcode +"'," +
                        "TO_DATE('"+ saledate +"','YYYY-MM-DD'),"+
                        "'" + scode + "'," +
                        amount + ")";
        stmt.executeUpdate(sql);
%>
    <jsp:include page="db_select_sale.jsp"></jsp:include>
<%
    }catch (Exception e){
        e.printStackTrace();
    }
%>


