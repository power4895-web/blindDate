package com.example.self_board_project.relationship.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RelationshipMapper {
    public String insertRelationship(int sendId);
}
