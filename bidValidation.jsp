<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.JavaReminder"%>
<%@ page import="com.google.appengine.api.utils.SystemProperty"%>
<%
	String userId = request.getParameter("uid");
	String itemId = request.getParameter("itemid");
	JavaReminder javaReminder = new JavaReminder();
	Connection connection = null;
	int consequentresult = 0;
	if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {
		Class.forName("com.mysql.jdbc.GoogleDriver");
		connection = DriverManager.getConnection("jdbc:google:mysql://auctionsystem-1137:db/auctionsystem",
				"root", "");
	} else {
		Class.forName("com.mysql.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/auctionsystem", "root",
				"Admin2015");
	}

	Statement statement = connection.createStatement();
	ResultSet resultSet = statement
			.executeQuery("select max(bid_price) from bids WHERE itemid = '" + itemId + "'");
	resultSet.next();
	consequentresult = resultSet.getInt(1);
	boolean isExpired = javaReminder.isExpired(itemId);
	if (!isExpired) {
		request.setAttribute("itemid", itemId);
		request.setAttribute("uid", userId);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/preRegisterBid.jsp");
		dispatcher.forward(request, response);
	} else if (consequentresult != 0 && isExpired) {
		if (javaReminder.declareWinner(itemId) != null) {
			out.println(javaReminder.declareWinner(itemId));
%>
<a href="ownersView.jsp">User Control Panel</a>
;
<%
	}
	} else if (consequentresult == 0 && isExpired) {

		Connection conn = null;
		if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {

			Class.forName("com.mysql.jdbc.GoogleDriver");

			conn = DriverManager.getConnection("jdbc:google:mysql://auctionsystem-1137:db/auctionsystem",
					"root", "");

		} else {

			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/auctionsystem", "root",
					"Admin2015");
		}

		PreparedStatement ps = conn
				.prepareStatement("UPDATE representeditems SET updateDate = NOW() WHERE itemid = ?");
		ps.setString(1, itemId);
		int i = ps.executeUpdate();
		resultSet.close();
		ps.close();
		conn.close();
		out.println("<B> No one is selected yet! Time is Extended! You can go on </B>");
%>
<a href="preRegisterBid.jsp?itemid=<%=itemId%>&uid=<%=userId%>">Preregisteration</a>
;
<%
	}
%>