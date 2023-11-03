package com.example.self_board_project.relationship.service;

import com.example.self_board_project.chat.service.ChatService;
import com.example.self_board_project.chat.vo.Chat;
import com.example.self_board_project.notification.service.NotificationService;
import com.example.self_board_project.relationship.mapper.RelationshipMapper;
import com.example.self_board_project.relationship.vo.Relationship;
import com.example.self_board_project.room.service.RoomService;
import com.example.self_board_project.room.vo.Room;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.List;

@Service
public class RelationshipService {
    @Autowired
    RelationshipMapper relationshipMapper;
    @Autowired
    NotificationService notificationService;

    @Autowired
    RoomService roomService;
    @Autowired
    ChatService chatService;
    Logger logger = LoggerFactory.getLogger(getClass());
    public List<Relationship> selectRelationshipList(Relationship relationship) {
        return relationshipMapper.selectRelationshipList(relationship);
    }

    public List<Relationship> selectSendRelationshipList(Relationship relationship) {
        return relationshipMapper.selectSendRelationshipList(relationship);
    }
    public List<Relationship> selectExchangeRelationshipList(Relationship relationship) {
        List<Relationship> relationshipList = relationshipMapper.selectExchangeRelationshipList(relationship);

        //채팅방이 있는지 없는지 확인하고 없으면 채팅시작할수 있는 버튼을, 있으면 채팅방 이력이 있는지 까지 확인한 뒤 마지막 메세지 가져온다.
        Room room = new Room();
        int roomId = 0;

        // Calendar를 사용하여 연도, 월, 일을 추출
        Calendar calendar = Calendar.getInstance();

        for (Relationship item:relationshipList) {
            logger.info("sendId : {}", item.getSendId());
            logger.info("getId : {}", item.getGetId());
            room.setRoomStaffId(item.getGetId());
            room.setRoomBossId(item.getSendId());
            Room roomInfo = roomService.selectRoom(room);

            room.setRoomStaffId(item.getSendId());
            room.setRoomBossId(item.getGetId());
            Room roomInfo2 = roomService.selectRoom(room);

            if(roomInfo == null && roomInfo2 == null) {
                item.setRoomYn("N");
            } else {
                item.setRoomYn("Y");
            }
            if(roomInfo != null) {
                roomId = roomInfo.getId();
            }
            if(roomInfo2 != null) {
                roomId = roomInfo2.getId();
            }
            if(roomId != 0) {
                Chat chat = new Chat();
                chat.setRoomId(roomId);
                Chat lastChatInfo = chatService.selectLastChat(chat);
                if(lastChatInfo != null) {
                logger.info("미지막 메세지가 있다면");
                    chat.setToId(relationship.getGetId());
                    chat.setReadYn("N");
                    int setReadIsNotCount = chatService.countChat(chat);
                    item.setReadIsNotCount(setReadIsNotCount);
                    item.setLastMessage(lastChatInfo.getContent());

                    /*채팅기록이 있다면 채팅메세지 중 가장 최근데이터 calender에 넣기*/
                    calendar.setTime(lastChatInfo.getCreateDate());

                    //몇일 전 구하기
                    int yearValue = calendar.get(Calendar.YEAR);
                    int monthValue = calendar.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
                    int dayValue = calendar.get(Calendar.DAY_OF_MONTH);
                    logger.info("현재 채팅시점 연도 : {}" , yearValue);
                    logger.info("현재 채팅시점 월 : {}" , monthValue);
                    logger.info("현재 채팅시점 일 : {}" , dayValue);

                    LocalDate currentDate = LocalDate.now(); //현재날짜
                    LocalDate specificDate = LocalDate.of(yearValue, monthValue, dayValue); //채팅 보낸 년월일
                    logger.info("현재 채팅시점 년,월,일 localDate타입: {}" , specificDate);
                    long daysDifference = ChronoUnit.DAYS.between(specificDate, currentDate);
                    logger.info("현재날짜와 채팅날짜 차이: {}" , daysDifference);

                    logger.info("daysDifference : {}", daysDifference);
                    if (daysDifference >= 0) {
                        logger.info("현재 날짜 ({})와 특정 날짜 ({}) 사이의 차이는 ({})일 입니다." , currentDate ,  specificDate ,daysDifference);
                        item.setLastChatCreate(daysDifference);
                    } else {
                        logger.info("현재 날짜 ({})보다 특정 날짜 ({})가 미래입니다." , currentDate ,  specificDate);
                    }

                    //하루가 지나기 않았을 때, 시간, 분 , 초구하기
                    if (daysDifference == 0) {
                        logger.info(">>>>daysDifference가 0이다 == 오늘이다");
                        Calendar desiredTime = Calendar.getInstance();
                        Calendar now = Calendar.getInstance(); //현재시간

                        int hourValue = calendar.get(Calendar.HOUR_OF_DAY);
                        int minuteValue = calendar.get(Calendar.MINUTE);
                        int secondValue = calendar.get(Calendar.SECOND);

                        logger.info("현재 채팅시점 시간 : {}" , hourValue);
                        logger.info("현재 채팅시점 분 : {}" , minuteValue);
                        logger.info("현재 채팅시점 초 : {}" , secondValue);
                        desiredTime.set(Calendar.HOUR_OF_DAY, hourValue);
                        desiredTime.set(Calendar.MINUTE, minuteValue);
                        desiredTime.set(Calendar.SECOND, secondValue);


                        // 현재 시간과 원하는 시간의 차이 계산
                        long millisecondsDifference = desiredTime.getTimeInMillis() - now.getTimeInMillis();
                        int hoursDifference = (int) (millisecondsDifference / (1000 * 60 * 60));
                        int minutesDifference = (int) (millisecondsDifference / (1000 * 60) % 60);
                        int secondsDifference = (int) (millisecondsDifference / 1000 % 60);

                        // 결과 출력
                        logger.info("차이시간: {}  시간: {} 분: {} 초 : {}" , hoursDifference ,  minutesDifference ,secondsDifference);
                        item.setHourValue(-hoursDifference);
                        item.setMinuteValue(-minutesDifference);
                        item.setSecondValue(-secondsDifference);
                    }
                } else {
                    item.setLastMessage("메세지를 먼저 보내보세요.");
                    //view에서 비교를 위해, 값이 없을 땐 0으로 세팅
                    item.setLastChatCreate(0);
                    item.setHourValue(0);
                    item.setMinuteValue(0);
                    item.setSecondValue(0);
                }
            }
        }
        return relationshipList;
    }

    public List<Relationship> selectGetRelationshipList(Relationship relationship) {
        return relationshipMapper.selectGetRelationshipList(relationship);
    }

    public Relationship selectRelationship(Relationship relationship) {
        return relationshipMapper.selectRelationship(relationship);
    }

    public Relationship selectSendRelationship(Relationship relationship) {
        return relationshipMapper.selectSendRelationship(relationship);
    }

    public Relationship selectGetRelationship(Relationship relationship) {
        return relationshipMapper.selectGetRelationship(relationship);
    }

    public Boolean insertRelationship(Relationship relationship) {
        List<Relationship> relationshipList = selectRelationshipList(relationship);
        if (relationshipList.size() > 0) {
            logger.info("친구해요를 이미 보낸적이 있습니다.");
            return false;
        } else {
            logger.info("최초 친구해요를 보냅니다.");
            //근데 만약에 상대방이 이미 보냈다면?
            int userId = relationship.getSendId();
            int yourId = relationship.getGetId();
            relationship.setSendId(yourId);
            relationship.setGetId(userId);
            Relationship relationshipInfo = selectRelationship(relationship);
            if (relationshipInfo != null) {
                logger.info("상대방이 이미 친구해요를 보냈습니다. 수락합니다 relationshipId : {}", relationship.getId());
                //상대방이 보낸거 Y로 변경
                relationship.setId(relationshipInfo.getId());
                relationship.setAcceptCheck("Y");
                relationshipMapper.allowRelationship(relationship);

                //내가 상대방에서 Y로 친구해요 보내기
                relationship.setSendId(userId);
                relationship.setGetId(yourId);
                relationshipMapper.insertRelationship(relationship);
            }  else {
                logger.info("상대방이 친구해요를 보내지 않았습니다");
                relationship.setSendId(userId);
                relationship.setGetId(yourId);
                relationshipMapper.insertRelationship(relationship);
            }

            return true;
        }
    }

    /**
     * relationship 수정
     * @param relationship
     * @return
     */
    public int allowRelationship(Relationship relationship) {
        Relationship relationshipInfo = selectRelationship(relationship);
        relationship.setId(relationshipInfo.getId());
        relationship.setAcceptCheck("Y");
        relationshipMapper.allowRelationship(relationship);
        return relationshipInfo.getId();
    }

    /**
     * relationship 삭제
     * @param id
     * @return
     */
    public int deleteRelationship(int id) {
        return relationshipMapper.deleteRelationship(id);
    }
}