package com.example.self_board_project.relationship.mapper;

import com.example.self_board_project.relationship.vo.Relationship;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RelationshipMapper {
    public List<Relationship> selectRelationshipList(Relationship relationship);
    public Relationship selectRelationship(Relationship relationship);
    public void insertRelationship(Relationship relationship);
}
