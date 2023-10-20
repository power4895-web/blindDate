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
                Chat chatInfo = chatService.selectLastChat(chat);
                if(chatInfo != null) {
                    chat.setToId(relationship.getGetId());
                    chat.setReadYn("N");
                    int setReadIsNotCount = chatService.countChat(chat);
                    item.setReadIsNotCount(setReadIsNotCount);
                    item.setLastMessage(chatInfo.getContent());
                    item.setLastChatCreateDate(chatInfo.getCreateDate());
                } else {
                    item.setLastMessage("메세지를 먼저 보내보세요.");
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
            relationshipMapper.insertRelationship(relationship);
            return true;
        }
    }

    public int allowRelationship(Relationship relationship) {
        Relationship relationshipInfo = selectRelationship(relationship);
        relationship.setId(relationshipInfo.getId());
        relationshipMapper.allowRelationship(relationship);
        return relationshipInfo.getId();
    }
}