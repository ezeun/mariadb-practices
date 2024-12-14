package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CategoryVo;
import bookmall.vo.UserVo;

public class CategoryDao {
	
	public void insert(CategoryVo vo) {
		
		// insert 쿼리 이후에
		// Long no = select last_insert_id() from dual;
		// vo.setNo(no);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {

			conn = getConnection();
			
			// 3. Statement 준비하기
			String sql = "insert into category values (null, ?)";
			pstmt = conn.prepareStatement(sql);
			
			// 4. Parameter Binding  
			pstmt.setString(1, vo.getName()); 
			
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

	public List<CategoryVo> findAll() {
		List<CategoryVo> result = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			conn = getConnection();
			
			// 3. Statement 준비하기
			String sql = "select no, name"
							+ "	from category"
							+ "    order by no desc";
			pstmt = conn.prepareStatement(sql);
			
			// 5. SQL 실행
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Long no = rs.getLong(1);
				String name = rs.getString(2);
				
				CategoryVo vo = new CategoryVo();
				vo.setNo(no);
				vo.setName(name);
				
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
			String sql = "delete from category"
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
