package dao;
import java.sql.*;
import java.util.*;
import util.*;
import vo.*;

public class SubjectDao {
	// 1. 과목목록
	public ArrayList<Subject> selectSubjectListByPage(int beginRow, int rowPerPage) throws Exception {
		// 결과를 담아줄 list선언
		ArrayList<Subject> list = new ArrayList<>();
		
		// DBUtil에서 Connection가져오기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// subject 목록을 가져오는 쿼리
		String sql = "select subject_no, subject_name, subject_time, createdate, updatedate from subject limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// ?값 세팅
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		// 결과 실행 후 값 저장
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Subject sub = new Subject();
			sub.setSubjectNo(rs.getInt("subject_no"));
			sub.setSubjectName(rs.getString("subject_name"));
			sub.setSubjectTime(rs.getInt("subject_time"));
			sub.setCreatedate(rs.getString("createdate"));
			sub.setUpdatedate(rs.getString("updatedate"));
			list.add(sub);
		}
		return list;
	}
	
	// 2. 과목추가
	public int insertSubject(Subject subject) throws Exception {
		// subject 유효성 검사
		if(subject == null || subject.getSubjectName() == null) {
			System.out.println("유효하지 않은 과목 정보입니다.");
			return  0;
		}
		
		// 결과를 담아줄 row선언
		int row = 0;
		
		// DBUtil에서 Connection 가져오기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 과목을 추가해줄 쿼리
		String sql = "insert into subject(subject_name, subject_time, createdate, updatedate) values(?, ?, now(), now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// ?에 값 세팅
		stmt.setString(1, subject.getSubjectName());
		stmt.setInt(2, subject.getSubjectTime());
		
		// 실행 후 결과 저장
		row = stmt.executeUpdate();
	
		return row;
	}
	
	// 3. 과목삭제
	public int deleteSubject(int subjectNo) throws Exception {
		// 결과를 담아줄 row선언
		int row = 0;
		
		// DBUtil에서 Connection 가져오기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// subjectNo에 해당하는 데이터를 삭제해주는 쿼리
		String sql = "delete from subject where subject_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// ?값 세팅
		stmt.setInt(1, subjectNo);
		
		// 실행 후 결과 저장
		row = stmt.executeUpdate();
		
		return row;
		
	}
	
	// 4. 과목수정
	public int UpdateSubject(Subject subject) throws Exception {
		// subject 유효성 검사
		if(subject == null || subject.getSubjectName() == null) {
			System.out.println("유효하지 않은 과목 정보입니다.");
			return  0;
		}
		
		// 결과를 담아줄 row선언
		int row = 0;
		
		// DBUtil에서 Connection 가져오기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// subjectNo에 해당하는 데이터를 수정해주는 쿼리
		String sql = "update subject set subject_name = ?, subject_time = ?, updatedate = now() where subject_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// ?값 세팅
		stmt.setString(1, subject.getSubjectName());
		stmt.setInt(2, subject.getSubjectTime());
		stmt.setInt(3, subject.getSubjectNo());
		
		// 실행 후 결과 저장
		row = stmt.executeUpdate();
		
		return row;
	};
	
	// 5. 과목 상세정보
	public Subject selectSubjectOne(int subjectNo) throws Exception{
		// 결과를 담아줄 subject선언
		Subject subject = new Subject();
		
		// DBUtil에서 Connection 가져오기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// subjectNo에 해당하는 과목 상세정보를 불러오는 쿼리
		String sql = "select * from subject where subject_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// ?값 세팅
		stmt.setInt(1, subjectNo);
		
		//실행 후 결과 저장
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			subject.setSubjectNo(rs.getInt("subject_no"));
			subject.setSubjectName(rs.getString("subject_name"));
			subject.setSubjectTime(rs.getInt("subject_time"));
			subject.setCreatedate(rs.getString("createdate"));
			subject.setUpdatedate(rs.getString("updatedate"));
		}

		return subject;
	}
	
	// 6. 과목전체 row
	public int selectSubjectCnt() throws Exception {
		// 결과를 담아줄 row선언
		int row = 0;
		
		// DBUtil에서 Connection 가져오기
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 과목의 개수를 가져오는 쿼리
		String sql = "select count(*) cnt from subject";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		//실행 후 결과 값 저장
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		
		return row;
	}

}
