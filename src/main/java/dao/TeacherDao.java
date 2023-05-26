package dao;
import java.util.*;
import java.sql.*;
import util.*;

public class TeacherDao {
	public ArrayList<HashMap<String, Object>> selectTeacherListByPage(int beginRow, int rowPerPage) throws Exception{
		// 결과값을 저장해줄 HashMap list 선언
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		// Connection 가져오기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		// 선생님 리스트를 과목과 함께 가져오는 쿼리
		String sql = "SELECT t.teacher_no teacherNo, t.teacher_id teacherId, t.teacher_name teacherName, ifnull(group_concat(ts.subject_no), '없음') teacherSubjectNo, ifnull(GROUP_CONCAT(s.subject_name), '없음') teacherSubjectName FROM teacher t LEFT OUTER JOIN teacher_subject ts  ON t.teacher_no = ts.teacHer_no  LEFT OUTER join subject s ON ts.subject_no = s.subject_no  GROUP BY t.teacher_no, teacher_id, t.teacher_name LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// ? 값 세팅
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		//쿼리 실행 후 값 저장
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("teacherNo", rs.getInt("teacherNo"));
			map.put("teacherId", rs.getString("teacherId"));
			map.put("teacherName", rs.getString("teacherName"));
			map.put("teacherSubjectNo", rs.getString("teacherSubjectNo"));
			map.put("teacherSubjectName", rs.getString("teacherSubjectName"));
			list.add(map);
		}
		
		return list;
	}
	
	public int selectTeacherCnt () throws Exception{
		// 결과를 담아줄 row선언
		int row = 0;
		
		// DBUtil에서 Connection 가져오기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// teacher_subject 테이블에 있는 선생님 명 수를 가져오는 쿼리
		String sql = "SELECT count(*) cnt from teacher t";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// 실행 후 결과 저장
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		
		return row;
	}
}
