package com.example.self_board_project.notification.mapper;

import com.example.self_board_project.notification.vo.Notification;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface NotificationMapper {
    public Notification countNotification(Notification notification);
    public Notification selectNotification(Notification notification);
    public List<Notification> selectNotificationList(Notification notification);
    public void insertNotification(Notification notification);
    public void updateNotification(Notification notification);
}