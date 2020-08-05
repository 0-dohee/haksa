package students;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import database.Database;
import database.SqlVO;

public class StudentsDAO {
	// 학생 목록
	public JSONObject list(SqlVO vo) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="call list(?,?,?,?,?,?,?)";
			CallableStatement cs=Database.CON.prepareCall(sql);
			String tbl="(select s.*,pname from students s left join professors on advisor=pcode) tbl";
			cs.setString(1, tbl);
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setString(4, vo.getOrder());
			cs.setString(5, vo.getDesc());
			cs.setInt(6, vo.getPage());
			cs.setInt(7, vo.getPerPage());
			cs.execute();
			
			ResultSet rs=cs.getResultSet();
			JSONArray jArray=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("scode", rs.getString("scode"));
				obj.put("sname", rs.getString("sname"));
				obj.put("dept", rs.getString("dept"));
				obj.put("year", rs.getString("year"));
				obj.put("birthday", rs.getString("birthday"));
				obj.put("pname", rs.getString("pname"));
				obj.put("advisor", rs.getString("advisor"));
				jArray.add(obj);
			}
			jObject.put("array", jArray);
			
			// 검색 데이터 갯수
			cs.getMoreResults();
			rs=cs.getResultSet();
			int count=0;
			if(rs.next()) {
				count=rs.getInt("total");
			}
			int perPage=vo.getPerPage();
			int totPage=count%perPage==0?count/perPage:count/perPage+1;
			jObject.put("count", count); // 전체데이터
			jObject.put("page", vo.getPage()); // 현재페이지
			jObject.put("perPage", perPage); // 페이지당 갯수
			jObject.put("totPage", totPage); // 전체페이지
			
		}catch(Exception e) {
			System.out.println("학생 목록 출력 error: " + e.toString());
		}
		return jObject;
	}
	
	// 학생 정보 읽기
	public StudentsVO read(String scode) {
		StudentsVO vo=new StudentsVO();
		try {
			String sql="select s.*, pname from students s left join professors on advisor=pcode where scode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, scode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setScode(rs.getString("scode"));
				vo.setSname(rs.getString("sname"));
				vo.setDept(rs.getString("dept"));
				vo.setYear(rs.getString("year"));
				vo.setAdvisor(rs.getString("advisor"));
				vo.setPname(rs.getString("pname"));
				vo.setBirthday(rs.getDate("birthday"));
			}
		}catch(Exception e) {
			System.out.println("학생 정보 읽기 error: " + e.toString());
		}
		return vo;
	}
	
	// 학생 정보 수정
	public void update(StudentsVO vo) {
		try {
			String sql="update students set sname=?, dept=?, year=?, birthday=?, advisor=? where scode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getSname());
			ps.setString(2, vo.getDept());
			ps.setString(3, vo.getYear());
			ps.setDate(4, vo.getBirthday());
			ps.setString(5, vo.getAdvisor());
			ps.setString(6, vo.getScode());
			ps.execute();
		}catch(Exception e) {
			System.out.println("학생 정보 수정 error: " + e.toString());
		}
	}
	
	// 학생 등록
	public void insert(StudentsVO vo) {
		try {
			String sql="insert into students(scode,sname,dept,year,birthday,advisor) values(?,?,?,?,?,?)";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getScode());
			ps.setString(2, vo.getSname());
			ps.setString(3, vo.getDept());
			ps.setString(4, vo.getYear());
			ps.setDate(5, vo.getBirthday());
			ps.setString(6, vo.getAdvisor());
			ps.execute();
		}catch(Exception e) {
			System.out.println("학생 등록 error: " + e.toString());
		}
	}
	
	// 학생 삭제
	public int delete(String scode) {
		int count=-1;
		try {
			String sql="call del_stu(?,?)";
			CallableStatement cs=Database.CON.prepareCall(sql);
			cs.setString(1, scode);
			cs.registerOutParameter(2, java.sql.Types.INTEGER);
			cs.execute();
			count=cs.getInt(2);
		}catch(Exception e) {
			System.out.println("학생 삭제 error: " + e.toString());
		}
		return count;
	}
}
