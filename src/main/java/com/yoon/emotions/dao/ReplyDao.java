package com.yoon.emotions.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.yoon.emotions.vo.BoardVO;
import com.yoon.emotions.vo.ReplyVO;


@Mapper
public interface ReplyDao {
	
	/**
	 * 댓글 등록
	 * @param replyVO
	 * @return 성공시 1 이상 실패 시 0
	 */
	int replyInsert(ReplyVO replyVO);
	
	
	/**
	 * 댓글 전체 목록
	 * @param board_no 사용자가 목록에서 선택한 글의 번호
	 * @return 해당 번호로 조회되는 전체 댓글 목록
	 */
	List<ReplyVO> replyList(int board_no);
	
	/**
	 * 댓글 삭제 (삭제된 글입니다.로 수정)
	 * @param reply_no 해당 댓글의 번호
	 * @return 성공시 1 이상 실패 시 0
	 */
	int replyDelete(int reply_no);
	
	/**
	 * 대댓글 등록
	 * @param replyVO
	 * @return 성공시 1 이상 실패 시 0
	 */
	int addReply(ReplyVO replyVO);
	
	/**
	 * 답글 수정
	 * @param replyVO
	 * @return 성공시 1 이상 실패 시 0
	 */
	int editReply(ReplyVO replyVO);
	
	/**
	 * level_no 가져오기
	 * @param reply_no 해당 댓글의 번호
	 * @return 해당 번호의 level_no
	 */
	int findLevel(int reply_no);
	
	/**
	 * 댓글의 총갯수
	 * @return
	 */
	int totalReply(int board_no);
	
	/**
	 * 글 삭제했을때 댓글 전체 삭제
	 */
	int replyAllDel(BoardVO boardVo);
}	