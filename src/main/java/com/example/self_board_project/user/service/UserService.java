package com.example.self_board_project.user.service;

import com.example.self_board_project.evaluation.service.EvaluationService;
import com.example.self_board_project.evaluation.vo.Evaluation;
import com.example.self_board_project.relationship.service.RelationshipService;
import com.example.self_board_project.relationship.vo.Relationship;
import com.example.self_board_project.user.mapper.UserMapper;
import com.example.self_board_project.user.vo.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserService {
    Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    public UserMapper userMapper;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private RelationshipService relationshipService;
    @Autowired
    private EvaluationService evaluationService;

    public int selectUserCount() {
        System.out.println(">>");
        return 1;
    }
    public List<User> selectUserList(User user) {

        return userMapper.selectUserList(user);
    }
    public List<User> selectUserRandomList(User user) {

        return userMapper.selectUserRandomList(user);
    }
    public User selectUser(User user) {
        return userMapper.selectUser(user);
    }
    public User findByEmail(String email) {
        return userMapper.findByEmail(email);
    }
    public void insertUser(User user) {

        //todayprofileId 2개 지정
        String todayProfileId = "";
        String userIds = "";
        //회원의 반대성별로 찾아야 하니
        if(user.getGender().equals("M")) {
            user.setGender("F");
        } else {
            user.setGender("M");
        }
        //오늘의 프로필 id 2개 추가하깉
        user.setLimit(2);
        user.setOrder("rand");
        List<User> userList = selectUserList(user);
        for(int i=0; i < userList.size(); i++){
            todayProfileId += userList.get(i).getId() + ",";
        }
        todayProfileId = todayProfileId.substring(0, todayProfileId.length() - 1);
        user.setTodayProfileId(todayProfileId);
        logger.info("todayProfileId : {}", todayProfileId);

        //insert할 땐 다시 회원의 성별로
        if(user.getGender().equals("M")) {
            user.setGender("F");
        } else {
            user.setGender("M");
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole("ROLE_USER");
        userMapper.insertUser(user);
    }
    public void updateUser(User user) {
//        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userMapper.updateUser(user);
    }
    public void updateTodayProfileId(User user) {
        userMapper.updateTodayProfileId(user);
    }

    /**
     * 오늘의 프로필 업데이트, 배치
     * @param user
     */
    public void todayRandom(User user) {
        logger.info("todayRandom user : {}", user.getId());
        List<User> arrayUserList = new ArrayList<>();

        //user.getId가 있는 경우는, 현재 오늘의 소개회원이 없어 로그인한 회원의 아이디로 이 메소드가 호출된 경우, arrayUserList에 넣는다.
        //user.getId가없는 경우는, 12시지나서 모든 회원들의 정보를 arrayUserList에 넣는다.
        if(user.getId() != null) {
            arrayUserList.add(selectUser(user));
        } else {
            List<User> userList = selectUserList(user);
            for (User item:userList) {
                arrayUserList.add(item);
            }
        }

        for (User item: arrayUserList) {
            String todayProfileId = "";

            /*친구해요*/
            Relationship relationship = new Relationship();
            relationship.setSendId(item.getId());
            //현재 회원의 친구해요 보낸사람 list 가져와서 내가 친구해요를 보낸 사람의 아이디(getId)를 가져온 후 getId를 ids에 다 담아 user를 검색할 때
            //getId가 없는 유저만 검색(결국 친구해요 안한 회원들만 검색하게 된다)
            List<Relationship> relationshipList = relationshipService.selectRelationshipList(relationship);
            List<Integer> ids = new ArrayList<>();
            for (int i = 0; i < relationshipList.size(); i++) {
                ids.add(relationshipList.get(i).getGetId());
            }
            //호감
            Evaluation evaluation = new Evaluation();
            evaluation.setEvaluationId(item.getId());
            List<Evaluation> evaluationList = evaluationService.selectEvaluationList(evaluation);
            for (int i = 0; i < evaluationList.size(); i++) {
                ids.add(evaluationList.get(i).getReceiveId());
            }
            List<Integer> distinctIds = ids.stream().distinct().collect(Collectors.toList());
            user.setIds(distinctIds);
            user.setLimit(2);
            if(item.getGender().equals("M")) {
                user.setGender("F");
                user.setId(item.getId());
                List<User> femailRandomList = selectUserRandomList(user);
                for (User item2: femailRandomList) {
                    todayProfileId += item2.getId() + ",";
                }
                todayProfileId = todayProfileId.substring(0, todayProfileId.length() - 1);
                user.setTodayProfileId(todayProfileId);
                user.setId(item.getId());
                updateTodayProfileId(user);
            } else {
                user.setGender("M");
                List<User> manRandomList = selectUserRandomList(user);
                for (User item2: manRandomList) {
                    todayProfileId += item2.getId() + ",";
                }
                todayProfileId = todayProfileId.substring(0, todayProfileId.length() - 1);
                user.setTodayProfileId(todayProfileId);
                user.setId(item.getId());
                updateTodayProfileId(user);
            }
        }
    }

    /**
     * 회원 더보기 리스트
     * 친구, 호감, 오늘의프로필, 삭제한 프로필카드 아이디 제외
     * @param user
     * @return
     */
    public List<User> randomList(User user) {
        logger.info("todayRandom user : {}", user.getId());
        User userInfo = selectUser(user);
        /*친구해요*/
        Relationship relationship = new Relationship();
        relationship.setSendId(user.getId());
        //현재 회원의 친구해요 보낸사람 list 가져와서 내가 친구해요를 보낸 사람의 아이디(getId)를 가져온 후 getId를 ids에 다 담아 user를 검색할 때
        //getId가 없는 유저만 검색(결국 친구해요 안한 회원들만 검색하게 된다)

        //친구해요 제외
        List<Relationship> relationshipList = relationshipService.selectRelationshipList(relationship);
        List<Integer> ids = new ArrayList<>();
        for (int i = 0; i < relationshipList.size(); i++) {
            ids.add(relationshipList.get(i).getGetId());
        }
        //호감 제외
        Evaluation evaluation = new Evaluation();
        evaluation.setEvaluationId(user.getId());
        List<Evaluation> evaluationList = evaluationService.selectEvaluationList(evaluation);
        for (int i = 0; i < evaluationList.size(); i++) {
            ids.add(evaluationList.get(i).getReceiveId());
        }
        //오늘의 프로필 제외
        String[] todayProfileIds = userInfo.getTodayProfileId().split(",");
        for (String value : todayProfileIds) {
            ids.add(Integer.parseInt(value));
        }

        //삭제한 아이디 제외
        logger.info("getDeleteIds : {}" , userInfo.getDeleteIds());
        if(userInfo.getDeleteIds() != null) {
            // 문자열에 ','가 포함되어 있는지 여부 확인
            String[] resultArray;
            if(userInfo.getDeleteIds().contains(",")) {
                resultArray = userInfo.getDeleteIds().split(",");
            } else {
                resultArray = new String[]{userInfo.getDeleteIds()};
            }
            for (String test : resultArray) {
                logger.info("test : {}", test);
                ids.add(Integer.parseInt(test));
            }
        }
        logger.info("ids : {}" , ids);

        List<Integer> distinctIds = ids.stream().distinct().collect(Collectors.toList());
        logger.info("first distinctIds: 친구해요, 매력 측장, 오늘의 프로필아이디, 삭제한아이디 중복제거  : {}" + distinctIds);
        user.setIds(distinctIds);


        //반대성별
        if(userInfo.getGender().equals("M")) {
            user.setGender("F");
            user.setLimit(10);
        } else {
            user.setGender("M");
            user.setLimit(10);
        }
        user.setFlag("M");
        List<User> randomUserList = selectUserRandomList(user);
        return randomUserList;
    }


    public void deleteUserIds(User user, String id) {
        User userInfo = selectUser(user);
        if(userInfo.getDeleteIds() != null) {
            userInfo.setDeleteIds(userInfo.getDeleteIds()  + "," + id);
        } else {
            userInfo.setDeleteIds(id);
        }
        userMapper.updateUser(userInfo);
    }
}
