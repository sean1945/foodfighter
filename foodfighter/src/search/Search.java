package search;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class Search {
	private Connection conn;
	
	public Search() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String target = "jdbc:mysql://3.37.233.74:3306/foodfighter";
			this.conn = DriverManager.getConnection(target, "chris", "3pe6gq8c");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 검색 가능한 식당 종류를 불러옵니다.
	 * @param list 식당 목록
	 * @return String[]
	 */
	public String[] getFtypeList(ArrayList<SearchRestaurant> list) {
		String ftypes = "";
		
		for (SearchRestaurant e : list) {
			String ftype = e.getFtype();
			if (ftypes == "") {
				ftypes = ftype;
			} else if (ftypes.indexOf(ftype) == -1) {
				ftypes += "@" + ftype;
			}
		}
		String[] ftypeList = ftypes.split("@");
		
		return ftypeList;
	}
	
	/**
	 * 모든 종류의 식당 목록을 불러옵니다.
	 * @param str 검색어
	 * @return ArrayList<SearchRestaurant>
	 */
	public ArrayList<SearchRestaurant> search(String str) {
		return search(str, null);
	}
	
	/**
	 * 특정 종류의 식당 목록을 불러옵니다.
	 * @param str 검색어
	 * @param ftype 식당 종류
	 * @return ArrayList<SearchRestaurant>
	 */
	public ArrayList<SearchRestaurant> search(String str, String ftype) {
		String sql = new String();
		
		if (isInRegionList(str)) {
			sql = "SELECT idx, name, region1, region2, addr2, ftype, price, score "
					+ "FROM restaurant "
					+ "WHERE region1 REGEXP '?' or region2 REGEXP '?'";
			sql = sql.replace("?", str);
		} else if (isLocationName(str)) {
			sql = "SELECT idx, name, region1, region2, addr2, ftype, price, score "
					+ "FROM restaurant "
					+ "WHERE addr2 REGEXP '?'";
			sql = sql.replace("?", str);
		} else {
			sql = searchString(str);
		}
		
		// ftype이 있는 경우
		if (ftype != null) {
			sql = "SELECT grouped.idx, grouped.name, grouped.region1, grouped.region2, grouped.addr2, grouped.ftype, grouped.price, grouped.score "
					+ "FROM restaurant as grouped "
					+ "JOIN ("
					+ sql
					+ ") as nogroup "
					+ "ON grouped.idx = nogroup.idx "
					+ "WHERE grouped.ftype = '" + ftype + "'";
		}
		// 디버그용 출력
		// System.out.println(sql);

		ArrayList<SearchRestaurant> list = new ArrayList<SearchRestaurant>();
		
		try {
			Statement mainStmt = conn.createStatement();
			ResultSet rs = mainStmt.executeQuery(sql);
			
			while (rs.next()) {
				SearchRestaurant rest = new SearchRestaurant();
				
				rest.setIdx(rs.getInt("idx"));
				rest.setName(rs.getString("name"));
				rest.setRegion1(rs.getString("region1"));
				rest.setRegion2(rs.getString("region2"));
				rest.setAddress(rs.getString("addr2"));
				rest.setFtype(rs.getString("ftype"));
				rest.setPrice(rs.getString("price"));
				rest.setScore(rs.getString("score"));
				rest.setImage(getRestaurantImage(rs.getInt("idx")));
				
				list.add(rest);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	/**
	 * 검색어가 restaurant 테이블의 region1, region2 중에 존재하는 경우 true를 돌려줍니다.
	 * @param str
	 * @return boolean
	 */
	private boolean isInRegionList(String str) {
		int length = str.length();
		if (length > 2 && length < 5) {
			str = str.substring(0, str.length() - 1);
		}
		
		String sql = "SELECT count(1) as c "
				+ "FROM (SELECT region1, region2 FROM restaurant GROUP BY region1, region2) as r "
				+ "WHERE region1 REGEXP ? or region2 REGEXP ?";
		
		try {
			PreparedStatement regionPstmt = conn.prepareStatement(sql);
			regionPstmt.setString(1, str);
			regionPstmt.setString(2, str);
			
			ResultSet rs = regionPstmt.executeQuery();
			
			rs.next();
			if (rs.getInt("c") != 0) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	/**
	 * 검색어가 지역명인지 확인하고, 조건과 일치하는 경우 true를 리턴합니다.
	 * @param str 검색어
	 * @return boolean
	 */
	private boolean isLocationName(String str) {
		// 검색어가 5자 이상일 경우 지역명이 아니라고 판단합니다. 
		if (str.length() > 4) {
			return false;
		}
		
		char[] district = {'시', '도', '군', '구', '읍', '면', '동'};
		char lastChar = str.charAt(str.length() - 1);
		
		for (char c : district) {
			if (c == lastChar) {
				return true;
			}
		}
		
		// 상단의 for문에서 true를 리턴하지 못한 경우 false를 리턴합니다.
		return false;
	}
	
	private String searchString(String str) {
		String sql = "SELECT idx, NAME, region1, region2, addr2, ftype, price, score "
				+ "FROM restaurant "
				+ "WHERE name REGEXP ('?') or ftype REGEXP ('?') "
				+ "UNION "
				+ "SELECT idx, NAME, region1, region2, addr2, ftype, price, score "
				+ "FROM restaurant, (SELECT rest_idx FROM menu WHERE menu REGEXP ('?')) AS n "
				+ "WHERE restaurant.idx = n.rest_idx";

		// 검색어의 어절이 두개 이상일 경우 각각 검색
		// PreparedStatement의 setString은 단어마다 강제적으로 작은 따옴표가 붙기 때문에,
		// REGEXP 활용에 방해가 되므로 SQL의 물음표(?)를 직접 대체함
		String[] segment = str.split(" ");
		if (segment.length == 2) {
			sql = sql.replace("?", segment[0] + "|" + segment[1]);
		} else if (segment.length > 2) {
			String replacement = "";
			for (int i = 0; i < segment.length; i++) {
				if (i == 0 || i == segment.length - 1) {
					replacement += segment[i];
				} else {
					replacement += "|" + segment[i] + "|"; 
				}
			}
			sql = sql.replace("?", replacement);
		} else {
			sql = sql.replace("?", str);
		}
		
		return sql;
	}
	
	/**
	 * 검색 페이지에 출력할 레스토랑 이미지를 가져옵니다.
	 * @param idx 레스토랑 idx
	 * @return String[] {이미지 경로1, 이미지 경로2...}
	 */
	/*
	 * private String[] getRestaurantImage(int idx) { String sql =
	 * "SELECT image " + "FROM image " + "WHERE rest_idx = ?"; String[] src =
	 * null;
	 * 
	 * try { PreparedStatement imagePstmt = conn.prepareStatement(sql);
	 * imagePstmt.setInt(1, idx);
	 * 
	 * ResultSet rs = imagePstmt.executeQuery();
	 * 
	 * rs.last(); int row = rs.getRow(); rs.beforeFirst();
	 * 
	 * src = new String[row];
	 * 
	 * for (int i = 0; i < row; i++) { rs.next(); src[i] =
	 * rs.getString("image"); } } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return src; }
	 */
	private String getRestaurantImage(int idx) {
		String sql = "SELECT image "
				+ "FROM image "
				+ "WHERE rest_idx = ?";
		String imgRetString = null;
		try {
			PreparedStatement imagePstmt = conn.prepareStatement(sql);
			imagePstmt.setInt(1, idx);
			
			ResultSet rs = imagePstmt.executeQuery();
			rs.next();
			imgRetString = rs.getString("image");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return imgRetString;
	}

	/**
	 * 사용자가 지역명을 검색했을 시 해당 지역의 좌표를 찾아와 그 지역을 포함한 근방의 식당을 찾는 방식을 구상해보았습니다.
	 * 하지만 그럼 restaurant 테이블에 x좌표, y좌표 컬럼을 추가해야 할지도 모르는데, 유연하진 않지만 다른 방법도 있는데다 번거로워서 당장은 코드만 작성하고 빼놨습니다.  
	 * @param str 검색어
	 * @return JSONObject
	 */
	private JSONObject getGeocode(String str) {
		JSONObject data = new JSONObject();
		
		try {
			String link = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=" + str;
			URL url = new URL(link);
			HttpURLConnection huc = (HttpURLConnection) url.openConnection();
			huc.setRequestProperty("X-NCP-APIGW-API-KEY-ID", "q0npl34lwr");
			huc.setRequestProperty("X-NCP-APIGW-API-KEY", "k5851jcHv2tP6nFTr1isOOZtfEaTapIlGRSH38th");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			String result = br.readLine();
			
			JSONParser jsonParser = new JSONParser();
			data = (JSONObject)jsonParser.parse(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return data;
	}
}
