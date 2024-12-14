package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CartVo;
import bookmall.vo.UserVo;
import emaillist.vo.EmaillistVo;

public class UserDao {

	public void insert(UserVo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {

			conn = getConnection();
			
			// 3. Statement 준비하기
			String sql = "insert into user values (null, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			// 4. Parameter Binding  
			pstmt.setString(1, vo.getName()); 
			pstmt.setString(2, vo.getEmail()); 
			pstmt.setString(3, vo.getPassword()); 
			pstmt.setString(4, vo.getPhone()); 
			
			// 5. SQL 실행
			pstmt.executeUpdate();
			
			// no값 세팅
			Long no = null;
			pstmt = conn.prepareStatement("select last_insert_id() from dual");
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) no = rs.getLong(1);
			vo.setNo(no);
			
			
		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			try {
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}

	public List<UserVo> findAll() {
		List<UserVo> result = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			conn = getConnection();
			
			// 3. Statement 준비하기
			String sql = "select no, name, email, password, phone"
							+ "	from user"
							+ "    order by no desc";
			pstmt = conn.prepareStatement(sql);
			
			// 5. SQL 실행
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Long no = rs.getLong(1);
				String name = rs.getString(2);
				String email = rs.getString(3);
				String password = rs.getString(4);
				String phone = rs.getString(5);
				
				UserVo vo = new UserVo();
				vo.setNo(no);
				vo.setName(name);
				vo.setEmail(email);
				vo.setPassword(password);
				vo.setPhone(phone);
				
				result.add(vo); 
			}
			
		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			try {
				if(rs != null)
					rs.close();
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}

	public void deleteByNo(Long no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			
			conn = getConnection();
			
			// 3. Statement 준비하기
			String sql = "delete from user"
						+ " where no = ?";
			pstmt = conn.prepareStatement(sql);
			
			// 4. Parameter Binding  
			pstmt.setLong(1,no); 
			
			// 5. SQL 실행
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			try {
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		try {
			// 1. JDBC Driver 로딩
			Class.forName("org.mariadb.jdbc.Driver");
	
			// 2. 연결하기 
			String url = "jdbc:mariadb://192.168.0.118:3306/bookmall";
			conn = DriverManager.getConnection(url, "bookmall", "bookmall");
			
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패:" + e);
		} 
		
		return conn;
	}
}
