<%
    if ((session.getAttribute("uid") == null) || (session.getAttribute("uid") == "")) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
Welcome <b><%=session.getAttribute("username")%></b>
<BR>
<a href='logout.jsp'>Log out</a> &nbsp&nbsp&nbsp   <a href='ownersView.jsp'>User Control Panel</a>
<%
    }
%>
