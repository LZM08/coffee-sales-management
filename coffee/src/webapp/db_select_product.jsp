<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
%>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Document 3-7</title>
    <link rel="stylesheet" href="css/style.css?after">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<style>
    a:nth-child(5){
        text-decoration: underline;
    }
</style>
<body>
<header><jsp:include page="header.jsp" /></header>
<nav><jsp:include page="nav.jsp" /></nav>
<section>
    <h3>판메 순위</h3>
    <table border="1" class="table table-striped-columns">
        <tr>
            <td>상품코드</td>
            <td>상품명</td>
            <td>상품별 판매액</td>
        </tr>
        <%
            Connection conn;
            Statement stmt;

            try {
                conn = Util.getConnection();
                stmt = conn.createStatement();
                String sql =
                        "select " +
                                "a.pcode, " +
                                "a.name, " +
                                "to_char(sum(a.cost*c.amount), '999,999,999,999') cost " +
                                "from " +
                                "tbl_product_01 a, tbl_salelist_01 c " +
                                "where " +
                                "a.pcode=c.pcode " +
                                "group by a.pcode, a.name " +
                                "order by 1 ";

                ResultSet rs = stmt.executeQuery(sql);

                while (rs.next()) {
        %>
        <tr>
            <td><%=rs.getString("pcode")%></td>
            <td><%=rs.getString("name")%></td>
            <td><%=rs.getString("cost")%></td>
        </tr>

        <%
                }   // end while
            }   // end try
            catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</section>
<footer><jsp:include page="footer.jsp" /></footer>
</body>
</html>