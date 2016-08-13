<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty"%>
<%
    String itemId = request.getParameter("itemId");
    String amount = request.getParameter("suggestedPrice");
    //Class.forName("com.mysql.jdbc.GoogleDriver");
    //Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/auctionsystem",
    //        "root", "Admin2015");
    String url = null;
    Connection conn = null;
    if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {
  		// Connecting from App Engine.
  		// Load the class that provides the "jdbc:google:mysql://"
  		// prefix.
  		Class.forName("com.mysql.jdbc.GoogleDriver");
  	//	url = "jdbc:google:mysql://auctionsystem-1137:db?user=root";
  		conn = DriverManager.getConnection("jdbc:google:mysql://auctionsystem-1137:db/auctionsystem", "root","");
  		//"jdbc:google:mysql://<your-project-id>:<your-instance-name>/<your-database-name>?user=root";
  	} else {
  		// You may also assign an IP Address from the access control
  		// page and use it to connect from an external network.
  		// Local MySQL instance to use during development.
  		Class.forName("com.mysql.jdbc.Driver");
  		//url = "jdbc:mysql://127.0.0.1:3306/auctionsystem?user=root,password=Admin2015";
  		conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/auctionsystem", "root","Admin2015");
  	}

    PreparedStatement ps = conn.prepareStatement("UPDATE representeditems SET base_price = ? WHERE id = ?");

    ps.setString(1, amount);
    ps.setString(2, itemId);
    int i = ps.executeUpdate();
    ps.close();
    conn.close();

    if (i > 0) {
        response.sendRedirect("ownersView.jsp");
    } else {
        response.sendRedirect("index.jsp");
    }
%>
