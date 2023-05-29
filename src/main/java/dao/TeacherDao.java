package dao;
import vo.*;
import java.util.*;
import java.sql.*;
import util.*;


public class TeacherDao {
	
	public HashMap<String, Object> selectTeacherOne(int teacherNo) throws Exception {
		// 결과값을 저장해줄 HashMap타입 변수선언
		HashMap<String, Object> result = new HashMap<>();
		Teacher teacher = new Teacher();
		
		// Connection 가져오기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// teacherNo에 해당하는 데이터 가져오는 쿼리
		String sql = "SELECT t.*, ifnull(group_concat(ts.subject_no), '없음') teacherSubjectNo, ifnull(GROUP_CONCAT(s.subject_name), '없음') teacherSubjectName FROM teacher t LEFT OUTER JOIN teacher_subject ts ON t.teacher_no = ts.teacHer_no LEFT OUTER join subject s ON ts.subject_no = s.subject_no WHERE t.teacher_no = ? GROUP BY t.teacher_no, teacher_id, t.teacher_name";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// ?값 세팅
		stmt.setInt(1, teacherNo);
		
		// 쿼리 실행 후 결과값 저장
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			teacher.setTeacherNo(rs.getInt("teacher_no"));
			teacher.setTeacherId(rs.getString("teacher_id"));
			teacher.setTeacherName(rs.getString("teacher_name"));
			teacher.setTeacherHistory(rs.getString("teacher_history"));
			teacher.setUpdatedate(rs.getString("updatedate"));
			teacher.setCreatedate(rs.getString("createdate"));
			result.put("teacherSubjectNo", rs.getString("teacherSubjectNo"));
			result.put("teacherSubjectName", rs.getString("teacherSubjectName"));
		}
		
		result.put("teacher", teacher);
		
		return result;
	}
	public int updateTeacher(Teacher teacher) throws Exception {
		// 결과값을 저장해줄 변수 선언
		int row = 0;
		
		// Connection 가져오기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// teacher 정보를 업데이트 하는 쿼리
		String sql = "update teacher set teacher_id = ?, teacher_name = ?, teacher_history = ? where teacher_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// ?값을 세팅
		stmt.setString(1, teacher.getTeacherId());
		stmt.setString(2, teacher.getTeacherName());
		stmt.setString(3, teacher.getTeacherHistory());
		stmt.setInt(4, teacher.getTeacherNo());
		
		// 실행 후 결과 값 저장
		row = stmt.executeUpdate();
		
		return row;
	}
	public int deleteTeacher(int teacherNo) throws Exception {
		// 결과값을 저장할 변수 선언
		int row = 0;
		
		// Connection 가져오기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// teacherNo에 해당하는 정보를 삭제하는 쿼리
		String sql = "delete from teacher where teacher_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// ?값 세팅
		stmt.setInt(1, teacherNo);

		// 실행 후 결과값 저장
		row = stmt.executeUpdate();
		
		return row;
	}
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
	
	public int selectTeacherCnt () throws Exception {
		// 결과를 담아줄 row선언
		int row = 0;
		
		// DBUtil에서 Connection 가져오기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 전체 선생님 수를 가져오는 쿼리
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
