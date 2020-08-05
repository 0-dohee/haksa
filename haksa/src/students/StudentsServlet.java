package students;

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

import courses.CoursesDAO;
import database.SqlVO;

@WebServlet(value= {"/stu/list", "/stu/read", "/stu/update", "/stu/insert", "/stu/delete"})
public class StudentsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		StudentsDAO sdao=new StudentsDAO();
		StudentsVO vo=new StudentsVO();
		RequestDispatcher dis=null;
		CoursesDAO cdao=new CoursesDAO();
		
		switch(request.getServletPath()) {
		case "/stu/read":
			vo=sdao.read(request.getParameter("scode"));
			request.setAttribute("vo", vo);
			request.setAttribute("clist", cdao.listAll());
			dis=request.getRequestDispatcher("read.jsp");
			dis.forward(request, response);
			break;
			
		case "/stu/list":
			SqlVO sqlVO=new SqlVO();
			
			String key=request.getParameter("key")==null?"scode":request.getParameter("key");
			String word=request.getParameter("word")==null?"":request.getParameter("word");
			String order=request.getParameter("order")==null?"scode":request.getParameter("order");
			String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
			String page=request.getParameter("page")==null?"1":request.getParameter("page");
			String perPage=request.getParameter("perPage")==null?"5":request.getParameter("perPage");
			
			sqlVO.setKey(key);
			sqlVO.setWord(word);
			sqlVO.setOrder(order);
			sqlVO.setDesc(desc);
			sqlVO.setPage(Integer.parseInt(page));
			sqlVO.setPerPage(Integer.parseInt(perPage));
			out.println(sdao.list(sqlVO));
			break;
		}	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		StudentsVO vo=new StudentsVO();
		StudentsDAO sdao=new StudentsDAO();
		PrintWriter out=response.getWriter();
		JSONObject jObject=new JSONObject();
		
		vo.setScode(request.getParameter("scode"));
		vo.setSname(request.getParameter("sname"));
		vo.setDept(request.getParameter("dept"));
		vo.setYear(request.getParameter("year"));
		vo.setAdvisor(request.getParameter("advisor"));
		try {
			java.sql.Date birthday=Date.valueOf(request.getParameter("birthday"));
			vo.setBirthday(birthday);
		}catch(Exception e) {}
		System.out.println(vo.toString());	
		switch(request.getServletPath()) {

		case "/stu/update":
			 sdao.update(vo);
			break;
			
		case "/stu/insert":
			StudentsVO v=sdao.read(vo.getScode());
			if(v.getScode()==null) {
				sdao.insert(vo);
				jObject.put("count", "0");
			}else {
				jObject.put("count", "1");
			}
			out.println(jObject);
			break;
			
		case "/stu/delete":
			jObject.put("count", sdao.delete(vo.getScode()));
			out.println(jObject);
			break;
		}
	}
}