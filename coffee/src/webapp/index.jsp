<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Util" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>커피 판매 관리 시스템</title>
    <link rel="stylesheet" type="text/css" href="css/style.css?after">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<header> <jsp:include page="header.jsp" /></header>
<nav> <jsp:include page="nav.jsp" />  </nav>
<main class="container mt-4">
    <section class="mb-3">
        <h1 class="text-center mb-3">커피 판매 관리 시스템에 오신 것을 환영합니다!</h1>
        <div class="row g-3">
            <!-- 총 수익 -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">우리 커피</h5>
                        <p class="card-text">
                            <%
                                Connection conn = null;
                                Statement stmt = null;
                                try {
                                    conn = Util.getConnection();
                                    stmt = conn.createStatement();
                                    String sql = "SELECT TO_CHAR(SUM(cost * amount), '999,999,999,999') AS total_earnings FROM TBL_SALELIST_01 JOIN TBL_PRODUCT_01 ON TBL_SALELIST_01.pcode = TBL_PRODUCT_01.pcode";
                                    ResultSet rs = stmt.executeQuery(sql);
                                    if (rs.next()) {
                                        out.print("현재까지의 총 수익: " + rs.getString("total_earnings") + " 원");
                                    } else {
                                        out.print("수익 정보를 찾을 수 없습니다.");
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    out.print("데이터베이스 오류가 발생했습니다.");
                                } finally {
                                    if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
                                    if (conn != null) try { conn.close(); } catch(SQLException ex) {}
                                }
                            %>
                        </p>
                        <a href="db_select_shop.jsp" class="btn btn-primary">자세히 보기</a>
                    </div>
                </div>
            </div>

            <!-- 인기 상품 -->
            <div class="col-md-4">
                <div class="card">
                    <%
                        String imageUrl = null;
                        String productName = "";
                        try {
                            conn = Util.getConnection();
                            stmt = conn.createStatement();

                            // 가장 판매량이 높은 제품을 찾는 쿼리
                            String sql = "SELECT NAME, IMAGE_URL FROM (SELECT p.NAME, p.IMAGE_URL, SUM(s.AMOUNT) AS TOTAL_SALES "
                                    + "FROM TBL_PRODUCT_01 p JOIN TBL_SALELIST_01 s ON p.PCODE = s.PCODE "
                                    + "GROUP BY p.NAME, p.IMAGE_URL "
                                    + "ORDER BY TOTAL_SALES DESC) WHERE ROWNUM = 1";
                            ResultSet rs = stmt.executeQuery(sql);
                            if (rs.next()) {
                                productName = rs.getString("NAME");
                                imageUrl = rs.getString("IMAGE_URL");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            productName = "데이터베이스 오류가 발생했습니다.";
                        } finally {
                            if (stmt != null) try { stmt.close(); } catch (SQLException ex) {}
                            if (conn != null) try { conn.close(); } catch (SQLException ex) {}
                        }
                    %>
                    <div class="d-flex justify-content-center">
                        <% if (imageUrl != null && !imageUrl.isEmpty()) { %>
                        <img src="<%= imageUrl %>" class="card-img-top" alt="<%= productName %>">
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">가장 인기 있는 제품: <%= productName %></h5>
                        <a href="db_select_product.jsp" class="btn btn-primary">상세 정보 보기</a>
                    </div>
                    <% } else { %>
                    <div class="card-body">
                        <h5 class="card-title">가장 인기 있는 제품이 없습니다</h5>
                        <p>현재 인기 상품 데이터가 없습니다.</p>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- 매출이 가장 높은 매장 -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">매출이 가장 높은 매장</h5>
                        <p class="card-text">
                            <%
                                try {
                                    conn = Util.getConnection();
                                    stmt = conn.createStatement();
                                    String sql = "SELECT C.scode, B.sname, TO_CHAR(SUM(A.cost * C.amount), '999,999,999,999') AS cost "
                                            + "FROM TBL_PRODUCT_01 A, TBL_SHOP_01 B, TBL_SALELIST_01 C "
                                            + "WHERE B.scode = C.scode AND A.pcode = C.pcode "
                                            + "GROUP BY C.scode, B.sname "
                                            + "ORDER BY 1";
                                    ResultSet rs = stmt.executeQuery(sql);
                                    if (rs.next()) {
                                        out.print("매출이 가장 높은 매장: " + rs.getString("SNAME") + " - 매출: " + rs.getString("cost") + " 원");
                                    } else {
                                        out.print("매장 데이터가 없습니다.");
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    out.print("데이터베이스 오류가 발생했습니다.");
                                } finally {
                                    if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
                                    if (conn != null) try { stmt.close(); } catch(SQLException ex) {}
                                }
                            %>
                        </p>
                        <a href="db_select_shop.jsp" class="btn btn-primary">상세 정보 보기</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
<footer> <jsp:include page="footer.jsp" /> </footer>
</body>
</html>
