package com.longd.sample;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


public class JsonSimple2 {

	public static void main(String[] args) throws ParseException {
		
		JSONParser par = new JSONParser();

		try {
			FileReader file = new FileReader("C:\\Users\\tjoeun-jr-902-20\\Downloads\\TL_SCCO_CTPRVN.json");
			Object obj = par.parse(file);
			JSONObject jsonobject = (JSONObject) obj;
			file.close();
			
			//System.out.println(jsonobject.get("my"));
			
			/*
			 * JSONObject a = new JSONObject(); 
			 * a = (JSONObject) jsonobject.get("features");
			 */
			/*
			 * JSONObject a = new JSONObject(); a = (JSONObject) jsonobject.get("features");
			 */
			
			JSONArray jsonArr = (JSONArray)jsonobject.get("features");
			System.out.println("즐겨찾기 : "+jsonArr.size());
			
			Map map = new HashMap();
			
			for (int i = 0; i<jsonArr.size(); i++) {
				JSONObject c = (JSONObject)jsonArr.get(i);
				JSONObject d = (JSONObject)c.get("geometry");
				
			}
			
			/*
			 * JSONObject b = new JSONObject(); b = (JSONObject) a.get("bookmarkSync");
			 * 
			 * JSONArray jsonArr = (JSONArray)b.get("bookmarks");
			 * System.out.println("즐겨찾기 : "+jsonArr.size());
			 * 
			 * Map map = new HashMap();
			 * 
			 * for (int i = 0; i<jsonArr.size(); i++) { 
			 * JSONObject c = (JSONObject)jsonArr.get(i); 
			 * c.get("bookmark"); 
			 * JSONObject maplist = (JSONObject)c.get("bookmark"); 
			 * map.put(i, maplist); 
			 * } 
			 * System.out.println(map);
			 * System.out.println(map.size());
			 */
			
/////////////////////////////////////////////////////////////////////
/*			
			java.sql.Statement stmt = null;
			Connection conn = null;
			PreparedStatement pstmt = null;   //객체 생성
			ResultSet rs = null;
			
			String url = "";
			String user = "";
			String password = "";
			
			try{
				//드라이버 로딩
				Class.forName("com.mysql.jdbc.Driver");
				//커넥션 객체
				conn = DriverManager.getConnection(url, user, password);
				
				System.out.println("DB 연결 성공");
				System.out.println("Connection : " + conn);
			
				stmt = conn.createStatement();
				
				String sql = "insert into map (  px, py, name, displayName, address, creationTime )"
						+ "VALUES ( ?, ? , ? , ? , ? , ? ) ";
				
				int count = 0;
				
				for (int i = 0; i<map.size(); i++) {
					//sql 실행
					pstmt = conn.prepareStatement(sql);

					// 입력데이터 매핑
					pstmt.setDouble(1, (Double)((Map) map.get(i)).get("px"));
					pstmt.setDouble(2, (Double)((Map) map.get(i)).get("py"));
					pstmt.setString(3, (String)((Map) map.get(i)).get("name"));
					pstmt.setString(4, (String)((Map) map.get(i)).get("displayName"));
					pstmt.setString(5, (String)((Map) map.get(i)).get("address"));
					pstmt.setLong(6, (Long)((Map) map.get(i)).get("creationTime")); 
					
					pstmt.executeUpdate();
					
					count++;
				}
				
				System.out.println("count : "+ count );
				
				
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
				
			}finally{
				if(rs != null) {				
					try {
						rs.close();
					} catch (SQLException e) {				
						e.printStackTrace();
					}
				}
				if(pstmt != null) {				
					try {
						pstmt.close();
					} catch (SQLException e) {				
						e.printStackTrace();
					}
				}
				if(conn != null) {				
					try {
						conn.close();
					} catch (SQLException e) {				
						e.printStackTrace();
					}
				}
			}//연결한 부분 닫아주기 finally는 반드시 수행되다.
			
			//ex) ps에서 수행하다 예외 발생시
			//rs는 null인 상태일 때 rs. 수행되면  
			//nullpointerexception이 수행되기 때문에 예외처리
			
*/		
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}