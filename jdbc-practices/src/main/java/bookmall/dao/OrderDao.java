package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CartVo;
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
			String sql = "insert into orders_book values (?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			
			// 4. Parameter Binding  
			pstmt.setLong(1, vo.getOrderNo()); 
			pstmt.setLong(2, vo.getBookNo()); 
			pstmt.setInt(3, vo.getQuantity()); 
			pstmt.setInt(4, vo.getPrice()); 
			
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

	public OrderVo findByNoAndUserNo(Long orderNo, Long userNo) {
		OrderVo result = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			conn = getConnection();
			
			// 3. Statement 준비하기
			String sql = "select no, user_no, number, status, payment, shipping"
							+ "	from orders"
							+ " where no = ? and user_no = ?"
							+ "    order by no desc";
			pstmt = conn.prepareStatement(sql);
			
			// 4. Parameter Binding  
			pstmt.setLong(1,orderNo); 
			pstmt.setLong(2,userNo); 
			
			// 5. SQL 실행
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				Long OrderNo = rs.getLong(1);
				Long UserNo = rs.getLong(2);
				String number = rs.getString(3);
				String status = rs.getString(4);
				int payment = rs.getInt(5);
				String shipping = rs.getString(6);
				
				OrderVo vo = new OrderVo();
				vo.setNo(OrderNo);				
				vo.setUserNo(UserNo);
				vo.setNumber(number);
				vo.setStatus(status);
				vo.setPayment(payment);
				vo.setShipping(shipping);
				
				result = vo;
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

	public List<OrderBookVo> findBooksByNoAndUserNo(Long orderNo, Long userNo) {
		List<OrderBookVo> result = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			conn = getConnection();
			
			// 3. Statement 준비하기
		    String sql = "SELECT ob.order_no, ob.quantity, ob.price, ob.book_no, b.title " +
	                 "FROM orders_book ob " +
	                 "JOIN orders o ON ob.order_no = o.no " +
	                 "JOIN book b ON ob.book_no = b.no " +
	                 "WHERE o.no = ? AND o.user_no = ?";
			pstmt = conn.prepareStatement(sql);
			
			// 4. Parameter Binding  
			pstmt.setLong(1,orderNo); 
			pstmt.setLong(2,userNo); 
			
			// 5. SQL 실행
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Long OrderNo = rs.getLong(1);
				int quantity = rs.getInt(2);
				int price = rs.getInt(3);
				Long BookNo = rs.getLong(4);
				String title = rs.getString(5);
				
				OrderBookVo vo = new OrderBookVo();
				vo.setOrderNo(OrderNo);
				vo.setQuantity(quantity);
				vo.setPrice(price);
				vo.setBookNo(BookNo);
				vo.setBookTitle(title);
				
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

	public void deleteBooksByNo(Long no) { //orderNo
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			
			conn = getConnection();
			
			// 3. Statement 준비하기
			String sql = "delete from orders_book"
						+ " where order_no = ?";
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

	public void deleteByNo(Long no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			
			conn = getConnection();
			
			// 3. Statement 준비하기
			String sql = "delete from orders"
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
