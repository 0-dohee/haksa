package professors;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import database.SqlVO;

@WebServlet(value= {"/pro/list", "/pro/ck", "/pro/cslist", "/pro/insert", "/pro/read", "/pro/delete", "/pro/update"})
public class ProfessorsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		ProfessorsDAO pdao=new ProfessorsDAO();
		JSONObject jObject=new JSONObject();
		
		switch(request.getServletPath()) {
		case "/pro/cslist":
			out.println(pdao.cslist(request.getParameter("pcode")));
			break;
		
		case "/pro/read":
			request.setAttribute("vo", pdao.read(request.getParameter("pcode")));
			RequestDispatcher dis=request.getRequestDispatcher("read.jsp");
			dis.forward(request, response);
			break;
			
		case "/pro/ck":
			int count=pdao.checkCode(request.getParameter("pcode"));
			jObject.put("count", count);
			out.println(jObject);
			break;
			
		case "/pro/list":
			SqlVO sqlVO=new SqlVO();
			
			String key=request.getParameter("key")==null?"pcode":request.getParameter("key");
			String word=request.getParameter("word")==null?"":request.getParameter("word");
			String order=request.getParameter("order")==null?"pcode":request.getParameter("order");
			String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
			String page=request.getParameter("page")==null?"1":request.getParameter("page");
			String perPage=request.getParameter("perPage")==null?"5":request.getParameter("perPage");
			
			sqlVO.setKey(key);
			sqlVO.setWord(word);
			sqlVO.setOrder(order);
			sqlVO.setDesc(desc);
			sqlVO.setPage(Integer.parseInt(page));
			sqlVO.setPerPage(Integer.parseInt(perPage));
			out.println(pdao.list(sqlVO));
			break;
		}	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		ProfessorsVO vo=new ProfessorsVO();
		ProfessorsDAO pdao=new ProfessorsDAO();
		JSONObject jObject=new JSONObject();
		PrintWriter out=response.getWriter();

		switch(request.getServletPath()) {
		case "/pro/insert":
			vo.setPcode(request.getParameter("pcode"));
			vo.setPname(request.getParameter("pname"));
			vo.setDept(request.getParameter("dept"));
			vo.setTitle(request.getParameter("title"));
			String salary=request.getParameter("salary");
			vo.setSalary(Integer.parseInt(salary));
			String yy=request.getParameter("yy");
			String mm=request.getParameter("mm");
			String dd=request.getParameter("dd");
			String strHiredate=yy + "-" + mm + "-" + dd;
			try {
				java.sql.Date hiredate=Date.valueOf(strHiredate);
				vo.setHiredate(hiredate);
			}catch(Exception e) {}
			pdao.insert(vo);
			response.sendRedirect("list.jsp");
			break;
			
		case "/pro/delete":
			out.println(pdao.delete(request.getParameter("pcode")));
			break;	
			
		case "/pro/update":
			vo.setPcode(request.getParameter("pcode"));
			vo.setPname(request.getParameter("pname"));
			vo.setDept(request.getParameter("dept"));
			vo.setTitle(request.getParameter("title"));
			salary=request.getParameter("salary");
			vo.setSalary(Integer.parseInt(salary));
			yy=request.getParameter("yy");
			mm=request.getParameter("mm");
			dd=request.getParameter("dd");
			strHiredate=yy + "-" + mm + "-" + dd;
			try {
				java.sql.Date hiredate=Date.valueOf(strHiredate);
				vo.setHiredate(hiredate);
			}catch(Exception e) {}
			pdao.update(vo);
			response.sendRedirect("list.jsp");
			break;
		}
	}
}
