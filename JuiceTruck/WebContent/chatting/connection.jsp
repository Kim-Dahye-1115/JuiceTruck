<html>
<head>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, javax.naming.InitialContext, javax.naming.Context" %>
</head>
<body>
<%
	InitialContext initCTX = new InitialContext();
	Context envContext = (Context) initCTX.lookup("java:/comp/env");
	DataSource ds = (DataSource) envContext.lookup("jdbc/JuiceDB");
	Connection con = ds.getConnection();
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery("select version();");
	while(rs.next()) {
		out.println("MySQL Version :" + rs.getString("version()"));
	}
	rs.close();
	stmt.close();
	con.close();
	initCTX.close();
%>
</body>
</html>