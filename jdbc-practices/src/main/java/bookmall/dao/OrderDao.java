package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bookmall.vo.OrderBookVo;
import bookmall.vo.OrderVo;

public class OrderDao {


	public void insert(OrderVo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {

			conn = getConnection();
			
			// 3. Statement 준비하기
			String sql = "insert into orders values (null, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			// 4. Parameter Binding  
			pstmt.setLong(1, vo.getUserNo()); 
			pstmt.setString(2, vo.getNumber()); 
			pstmt.setString(3, vo.getStatus()); 
			pstmt.setInt(4, vo.getPayment()); 
			pstmt.setString(5, vo.getShipping()); 
			
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

	public void insertBook(OrderBookVo vo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {

			conn = getConnection();
			
			// 3. Statement 준비하기
			String sql = "insert into orders values (null, null, null, null, null, null)";
			pstmt = conn.prepareStatement(sql);
			
			// 4. Parameter Binding  
//			pstmt.setLong(1, vo.getUserNo()); 
//			pstmt.setString(2, vo.getNumber()); 
//			pstmt.setString(3, vo.getStatus()); 
//			pstmt.setInt(4, vo.getPrice()); 
//			pstmt.setString(5, vo.getShipping()); 
			
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
			String url = "jdbc:mariadb://192.168.0.118:3306/webdb";
			conn = DriverManager.getConnection(url, "webdb", "webdb");
			
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패:" + e);
		} 
		
		return conn;
	}
}
