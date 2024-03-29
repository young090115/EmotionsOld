package com.yoon.emotions.serviceImpl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yoon.emotions.dao.ReplyDao;
import com.yoon.emotions.service.ReplyService;
import com.yoon.emotions.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

		@Autowired 
		private ReplyDao replyDao;

		/**
		 * 댓글 등록 
		 */
		@Override
		public int replyInsert(Map<String, String> ReplyData) {
			
			int board_no = Integer.parseInt(ReplyData.get("board_no")); 
			String text = ReplyData.get("text");
			String user_id = ReplyData.get("user_id");
			
			ReplyVO replyVo = new ReplyVO();
			
			replyVo.setBoard_no(board_no);
			replyVo.setText(text);
			replyVo.setUser_id(user_id);
			replyVo.setReply_no(0);
			replyVo.setLevel_no(0);
			
			int replyInsertResult = replyDao.replyInsert(replyVo);
					
			return replyInsertResult;
		}
		/**
		 * 댓글 삭제
		 */
		@Override
		public int replyDelete(int reply_no) {
			
			int replyDeleteResult = replyDao.replyDelete(reply_no);
			
			return replyDeleteResult;
		}
		
		
		/**
		 * 대댓글등록
		 */
		@Override
		public int addReply(Map<String, String> addReplyData) {
			
			int board_no = Integer.parseInt(addReplyData.get("board_no")); 
			String text = addReplyData.get("text");
			String user_id = addReplyData.get("user_id");
			int rf_reply_no = Integer.parseInt(addReplyData.get("reply_no")) ;
			
			int level_no = replyDao.findLevel(rf_reply_no);
			
			ReplyVO replyVo = new ReplyVO();
			
			replyVo.setBoard_no(board_no);
			replyVo.setText(text);
			replyVo.setUser_id(user_id);
			replyVo.setRf_reply_no(rf_reply_no);
			replyVo.setLevel_no(level_no+1);
			
			int addReplyResult = replyDao.replyInsert(replyVo);
			
			return addReplyResult;
		}

		/**
		 * 댓글 수정
		 */
		@Override
		public int editReply(Map<String, String> editReplyData) {
			
			int reply_no = Integer.parseInt(editReplyData.get("reply_no"));
			String text = editReplyData.get("text");
			
			text = text.replace("ㄴ","");
			
			ReplyVO replyVo = new ReplyVO();
			replyVo.setText(text);
			replyVo.setReply_no(reply_no);
			
			int editReplyResult = replyDao.editReply(replyVo);
			
			return editReplyResult;
		}
}
