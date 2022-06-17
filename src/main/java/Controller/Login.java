package Controller;

import Model.UserBean;
import Model.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "loginServlet", value = "/login-servlet")
public class Login extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO service = new UserDAO();
        UserBean user = service.doRetrieveByEmailAndPassword(email, password);

        if (user != null && user.isActive().equalsIgnoreCase("true")) {

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            RequestDispatcher dispatcher;

            if (user.isAdmin().equalsIgnoreCase("true")) {
                dispatcher = request.getRequestDispatcher("WEB-INF/admin/admin.jsp");
            }

            else {
                dispatcher = request.getRequestDispatcher("index.jsp");
            }

            PrintWriter out = response.getWriter();
            out.println("<div class=\"success\">\n" +
                    "    <span class=\"closebtn\" onclick=\"clearDiv();\">&times;</span> \n" +
                    "    <strong>Login eseguito</strong> \n" +
                    "    </div>");

            dispatcher.include(request, response);
            out.close();
        }

        else if (user == null) {

            PrintWriter out = response.getWriter();
            out.println("<div class=\"alert\">\n" +
                    "    <span class=\"closebtn\" onclick=\"clearDiv();\">&times;</span> \n" +
                    "    <strong>Attenzione!</strong> Email o password errate\n" +
                    "    </div>");

            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.include(request, response);
            out.close();
        }

        else if (user.isActive().equalsIgnoreCase("false")) {

            PrintWriter out = response.getWriter();
            out.println("<div class=\"alert\">\n" +
                    "    <span class=\"closebtn\" onclick=\"clearDiv();\">&times;</span> \n" +
                    "    <strong>Attenzione!</strong> Account disabilitato\n" +
                    "    </div>");

            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.include(request, response);
            out.close();
        }

        else {

            PrintWriter out = response.getWriter();
            out.println("<div class=\"alert\">\n" +
                    "    <span class=\"closebtn\" onclick=\"clearDiv();\">&times;</span> \n" +
                    "    <strong>Attenzione!</strong> Errore imprevisto\n" +
                    "    </div>");

            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.include(request, response);
            out.close();
        }
    }
}
