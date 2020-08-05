package enrollments;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import database.Database;

public class EnrollmentsDAO {
	// Ư�� �л��� ������û�� ���� ���
	public JSONObject enrcou(String scode) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="select view_ec.*, pname from view_ec join professors on instructor=pcode where scode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, scode);
			ResultSet rs=ps.executeQuery();
			
			JSONArray jArray=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("lcode", rs.getString("lcode"));
				obj.put("lname", rs.getString("lname"));
				obj.put("edate", rs.getString("edate"));
				obj.put("pname", rs.getString("pname"));
				obj.put("hours", rs.getInt("hours"));
				obj.put("room", rs.getString("room"));
				jArray.add(obj);
			}
			jObject.put("array", jArray);
		}catch(Exception e) {
			System.out.println("Ư�� �л��� ������û�� ���� ��� error: " + e.toString());
		}
		return jObject;
	}
	
	// ���� ��û
	public int insert(String scode, String lcode) {
		int count=-1;
		try {
			String sql="call add_enroll(?,?,?)";
			CallableStatement cs=Database.CON.prepareCall(sql);
			cs.setString(1, scode);
			cs.setString(2, lcode);
			cs.registerOutParameter(3, java.sql.Types.INTEGER);
			cs.execute();
			count=cs.getInt(3);
		}catch(Exception e) {
			System.out.println("���� ��û error: " + e.toString());
		}
		return count;
	}
	
	// ���� ���
	public void delete(String scode, String lcode) {
		try {
			String sql="delete from enrollments where scode=? and lcode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, scode);
			ps.setString(2, lcode);
			ps.execute();
		}catch(Exception e) {
			System.out.println("���� ��� error: " + e.toString());
		}
	}
	
	// Ư�� ���¸� ������û�� �л� ���
	public JSONObject enrstu(String lcode) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="select view_es.*, pname from view_es left join professors on advisor=pcode where lcode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs=ps.executeQuery();
			JSONArray jArray=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("scode", rs.getString("scode"));
				obj.put("sname", rs.getString("sname"));
				obj.put("dept", rs.getString("dept"));
				obj.put("pname", rs.getString("pname"));
				obj.put("year", rs.getString("year"));
				obj.put("grade", rs.getInt("grade"));
				String edate="";
				try { 
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
					edate=sdf.format(rs.getDate("edate"));
				}catch(Exception e) { } 
				obj.put("edate", edate);
				jArray.add(obj);
			}
			jObject.put("array", jArray);
		}catch(Exception e) {
			System.out.println("Ư�� ���¸� ������û�� �л� ��� error: " + e.toString());
		}
		return jObject;
	}
	
	// ���� ����
	public void update(String lcode, String scode, int grade) {
		try {
			String sql="update enrollments set grade=? where lcode=? and scode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setInt(1, grade);
			ps.setString(2, lcode);
			ps.setString(3, scode);
			ps.execute();
		}catch(Exception e) {
			System.out.println("���� ���� error: " + e.toString());
		}
	}
}
