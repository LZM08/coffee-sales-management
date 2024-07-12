<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Util" %>


<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> 판매현황 </title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="css/style.css?after">

<!-- 현재 메뉴에 밑줄표시 -->
<style>
    a:nth-child(3) {
        text-decoration: underline;
    }
</style>

<body>
<header> <jsp:include page="header.jsp" /> </header>
<nav>    <jsp:include page="nav.jsp" /> </nav>

<section>
    <h3>매출 현황</h3>
    <table border="1" class="table table-striped-columns">
        <tr>
            <td>비번호</td>
            <td>상품코드</td>
            <td>판매날짜</td>
            <td>매장코드</td>
            <td>상품명</td>
            <td>판매수량</td>
            <td>총판매액</td>
        </tr>

<%
    Connection conn;
    Statement stmt;

    try {
        conn = Util.getConnection();
        stmt = conn.createStatement();
        String sql =
                "select " +
                " B.saleno, " +
                "    A.pcode, " +
                //"    B.saledate, " +
                "    TO_CHAR(B.saledate, 'yyyy-mm-dd') saledate, " +
                "   B.scode, " +
                "   A.name, " +
                "   B.amount, " +
                "   TO_CHAR(A.cost * B.amount, '999,999,999,999') cost " +
                "from " +
                "    TBL_PRODUCT_01 A, TBL_SALELIST_01 B " +
                "where "+
                "    A.pcode = B.pcode ";


        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()){
%>
        <tr>
            <td><%=rs.getInt("saleno") %></td>
            <td><%=rs.getString("pcode") %></td>
            <td><%=rs.getString("saledate")%></td>
            <td><%=rs.getString("scode")%></td>
            <td><%=rs.getString("name")%></td>
            <td><%=rs.getInt("amount")%></td>
            <td><%=rs.getString("cost")%></td>
        </tr>
<%
        } // end while
    }  // end try
    catch (Exception e) {
        e.printStackTrace();
    }
%>


    </table>

</section>

<footer> <jsp:include page="footer.jsp" /> </footer>

</body>
</html>


