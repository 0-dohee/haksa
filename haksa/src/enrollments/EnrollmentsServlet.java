package enrollments;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

@WebServlet(value= {"/enrcou", "/enrstu", "/enrcou/insert", "/enrcou/delete", "/enrstu/update"})
public class EnrollmentsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		JSONObject jObject=new JSONObject();
		EnrollmentsDAO edao=new EnrollmentsDAO();
		
		switch(request.getServletPath()) {
		case "/enrcou":
			jObject=edao.enrcou(request.getParameter("scode"));
			out.println(jObject);
			break;
			
		case "/enrstu":
			jObject=edao.enrstu(request.getParameter("lcode"));
			out.println(jObject);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		EnrollmentsDAO edao=new EnrollmentsDAO();
		String scode=request.getParameter("scode");
		String lcode=request.getParameter("lcode");
		JSONObject jObject=new JSONObject();
		
		switch(request.getServletPath()) {
		case "/enrcou/insert":
			int count=edao.insert(scode, lcode);
			jObject.put("count", count);
			out.println(jObject);
			break;
			
		case "/enrcou/delete":
			edao.delete(scode, lcode);
			break;
			
		case "/enrstu/update":
			String strGrade=request.getParameter("grade");
			int grade=Integer.parseInt(strGrade);
			edao.update(lcode, scode, grade);
			break;
		}
	}
}

