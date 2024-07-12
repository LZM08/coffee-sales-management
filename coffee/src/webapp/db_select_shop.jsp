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
    <title> 매장별 판매액 </title>
</head>

<link rel="stylesheet" type="text/css" href="css/style.css?after">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- 현재 메뉴에 밑줄표시 -->
<style type="text/css">
    a:nth-child(4) {
        text-decoration: underline;
    }
</style>

<body>

<header> <jsp:include page="header.jsp" /> </header>
<nav>    <jsp:include page="nav.jsp" /> </nav>

<section>
    <h3>매장별 판매액</h3>

    <table border="1" class="table table-striped-columns">
        <tr>
            <td>매장코드</td>
            <td>매장명</td>
            <td>매장별 판매액</td>
        </tr>
<%
    Connection conn = null;
    Statement stmt = null;

    try {
        conn = Util.getConnection();
        stmt = conn.createStatement();
        String sql =
                "select" +
                        "   C.scode, B.sname, " +
                        "  To_CHAR(sum(A.cost * C.amount), '999,999,999,999') cost "+
                        "FROM" +
                        "   TBL_PRODUCT_01 A, TBL_SHOP_01 B, TBL_SALELIST_01 C " +
                        "where" +
                        "   B.scode = C.scode and A.pcode = c.pcode "+
                        "group by c.scode, B.sname "+
                        "order by 1";

        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
%>
        <tr>
            <td><%=rs.getString("scode") %></td>
            <td><%=rs.getString("sname") %></td>
            <td><%=rs.getString("cost") %></td>
        </tr>
<%
        } // end while
    }  // end try
    catch (Exception e){
        e.printStackTrace();
    }
%>
    </table>

</section>

<footer> <jsp:include page="footer.jsp" /> </footer>

</body>
</html>