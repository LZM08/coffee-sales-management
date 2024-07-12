<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> 판매등록 </title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="css/style.css?after">


<!-- 현재 메뉴에 밑줄표시 -->
<style>
    a:nth-child(2) {
        text-decoration: underline;
    }
</style>

<body>
<script type="text/javascript" src="reset.js"></script>
<header>    <jsp:include page="header.jsp" />   </header>
<nav>   <jsp:include page="nav.jsp" />  </nav>

<section>
    <h3>판매등록</h3>
    <%
        Connection conn = null;
        Statement stmt = null;
        String saleno = "";

        try{
            conn = Util.getConnection();
            stmt = conn.createStatement();
            String sql = "select max(saleno) + 1 saleno from TBL_SALELIST_01";

            ResultSet rs = stmt.executeQuery(sql);
            rs.next();
            saleno = rs.getNString("saleno");
        } catch (Exception e){
            e.printStackTrace();
        }
    %>


    <form name="frm_insert" action="action.jsp" method="post">
    <table border="1" class="table table-striped-columns">
        <tr>
            <td>판매번호</td>
            <td> <input type="text" name="saleno" value="<%= saleno %>"> </td>
        </tr>

        <tr>
            <td>상품코드</td>
            <td> <input type="text" name="pcode" value=""> </td>
        </tr>

        <tr>
            <td>판매날짜</td>
            <td> <input type="text" name="saledate" value=""> </td>
        </tr>

        <tr>
            <td>매장코드</td>
            <td> <input type="text" name="scode" value=""> </td>
        </tr>

        <tr>
            <td>판매수량 </td>
            <td> <input type="text" name="amount" value=""> </td>
        </tr>

        <tr>
            <td  colspan="2" align="center">
                <button class="btn btn-primary" onclick="return insertCheck()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send-fill" viewBox="0 0 16 16">
                        <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 3.178 4.995.002.002.26.41a.5.5 0 0 0 .886-.083zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471z"/>
                    </svg>
                </button>
                <button class="btn btn-primary" onclick="return reset()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z"/>
                        <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466"/>
                    </svg>
                </button>
            </td>

        </tr>

    </table>
    </form>

</section>

<footer> <jsp:include page="footer.jsp" /> </footer>

</body>
</html>