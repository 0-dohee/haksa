package user;

public class UserVO {
	// 필드(속성)
	public String id;
	public String pass;
	public String name;
	
	// get method, set method
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "UserVO [id=" + id + ", pass=" + pass + ", name=" + name + "]";
	}
}
