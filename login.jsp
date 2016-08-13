<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty"%>
<%


    String uname = request.getParameter("uname");
    String pwd = request.getParameter("pass");

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

    //Class.forName("com.mysql.jdbc.GoogleDriver"); // it obtains a reference to the class obj with fully qualified class name
    //Connection con = DriverManager.getConnection("jdbc:google:mysql://auctionsystem-1137:db?user=root");
    Statement st = conn.createStatement();


    ResultSet rs = st.executeQuery("select * from users where uname='" + uname
            + "' and pass='" + pwd + "'");
    //resultset true if the new current row is valid; false if there are no more rows
    if (rs.next()) {
        session.setAttribute("uid", rs.getInt(1));//index 1 is userid
        session.setAttribute("username", uname);
        //The difference is called the "scope". If you put a variable in a request,it will disappear when the request is over.
        //If you put a variable in a user session,it will disappear when the session is over.
        rs.close();
        st.close();
        conn.close();
        response.sendRedirect("success.jsp");
    } else {
        out.println("Invalid username or password <a href='index.jsp'>try again</a>");
    }
%>
