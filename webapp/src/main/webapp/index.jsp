<html>
<head><title>First JSP</title></head>
<body>
  <%
    double num = Math.random();
    if (num > 0.95) {
  %>
      <h2>Click below URL for login into CICD website !</h2><p>(<%= num %>)</p>
  <%
    } else {
  %>
      <h2>Welcome to Jenkins with tomcat CICD </h2><p>(<%= num %>)</p>
  <%
    }
  %>
  <a href="<%= request.getRequestURI() %>"><h3>Try Again</h3></a>
</body>
</html>
