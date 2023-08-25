package com.example.self_board_project.core.utils;

import org.springframework.stereotype.Component;

@Component
public class Pager {
    private int totalPage;          // 총 글의 수
    private int totalBlock;         // 총 블락의 수
    private int listCount;          // 한 블락에 담길 글의 수
    private int blockCount;         // 한 섹션에 담길 블락의 수
    private int currentBlock;       // 현재 블락의 위치
    private int currentSection;     // 현재 섹션의 위치
    private int startPage;          // 현재 블락에서 시작할 페이지의 번호
    private int limitPage;          // DB에서 사용할 페이지번호
    private int lastPage;           // 현재 블락에서 끝날 페이지의 번호
    private int startBlock;         // 페이지의 시작 블락
    private int lastBlock;          // 페이지의 끝 블락
    private int prevBlock;          // 이전 페이지 블락
    private int nextBlock;          // 다음 페이지 블락

    public int getTotalPage() {
        return totalPage;
    }
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalBlock() {
        return totalBlock;
    }
    public void setTotalBlock(int totalBlock) {
        this.totalBlock = totalBlock;
    }
    public int getListCount() {
        return listCount;
    }
    public void setListCount(int listCount) {
        this.listCount = listCount;
    }
    public int getBlockCount() {
        return blockCount;
    }
    public void setBlockCount(int blockCount) {
        this.blockCount = blockCount;
    }
    public int getCurrentBlock() {
        return currentBlock;
    }
    public void setCurrentBlock(int currentBlock) {
        this.currentBlock = currentBlock;
    }
    public int getCurrentSection() {
        return currentSection;
    }
    public void setCurrentSection(int currentSection) {
        this.currentSection = currentSection;
    }
    public int getStartPage() {
        return startPage;
    }
    public void setStartPage(int startPage) {
        this.startPage = startPage;
    }
    public int getLimitPage() {
        return limitPage;
    }
    public void setLimitPage(int limitPage) {
        this.limitPage = limitPage;
    }
    public int getLastPage() {
        return lastPage;
    }
    public void setLastPage(int lastPage) {
        this.lastPage = lastPage;
    }
    public int getStartBlock() {
        return startBlock;
    }
    public void setStartBlock(int startBlock) {
        this.startBlock = startBlock;
    }
    public int getLastBlock() {
        return lastBlock;
    }
    public void setLastBlock(int lastBlock) {
        this.lastBlock = lastBlock;
    }
    public int getPrevBlock() {
        return prevBlock;
    }
    public void setPrevBlock(int prevBlock) {
        this.prevBlock = prevBlock;
    }
    public int getNextBlock() {
        return nextBlock;
    }
    public void setNextBlock(int nextBlock) {
        this.nextBlock = nextBlock;
    }

    /**
     * @param totalPage 총개수
     * @param pageNum 시작블락
     * @param listCount 페이지에보일글개수
     * @param blockCount 블락개수
     */
    public void makingPage(int totalPage, String pageNum, int listCount, int blockCount) {
        this.totalPage = totalPage;
        this.listCount = listCount;
        this.blockCount = blockCount;

        // 전체 블락 TotalBlock
        this.totalBlock = totalPage / listCount;
        if (totalPage % listCount > 0) {
            totalBlock = totalPage / listCount + 1;
        }

        // 현재 블락 int형 변환 시도
        try {
            this.currentBlock = Integer.parseInt(pageNum);
        } catch (Exception e) {
            this.currentBlock = 1;
        }

        // 1. 현재 블락 파라미터가 존재하지않는 경우
        if (pageNum == null) {
            this.currentBlock = 1;
        }
        // 2. 현재 블락이 1보다 작으면
        else if (currentBlock < 1) {
            this.currentBlock = 1;
        }
        // 3. 현재 블락이 총블락보다 크면
        else if (currentBlock >= this.totalBlock) {
            this.currentBlock = this.totalBlock;
        }

        // 시작 페이지 StartPage
        this.startPage = (currentBlock - 1) * listCount + 1;
        // 마지막 페이지 LastPage
        this.lastPage = currentBlock * listCount;

        // 현재 섹션 CurrentSection
        this.currentSection = (currentBlock - 1) / blockCount + 1;
        if (currentBlock % blockCount > 0) {
            this.currentSection = currentBlock / blockCount + 1;
        }

        // 시작 블락 StartBlock
        this.startBlock = (this.currentSection - 1) * blockCount + 1;
        // 마지막 블락 LastBlock
        this.lastBlock = this.currentSection *blockCount;
        // 마지막 블락이 전체 블락보다 클때
        if (this.lastBlock > this.totalBlock) {
            this.lastBlock =  this.totalBlock;
        }

        // 이전 블락 PrevBlock
        this.prevBlock = this.currentSection * 5 - 9;
        if (this.prevBlock < 1) {
            this.prevBlock = 1;
        }
        // 다음 블락 NextBlock
        this.nextBlock = this.currentSection * 5 + 1;
        if (this.nextBlock > this.totalBlock) {
            this.nextBlock = this.totalBlock;
        }

        if(this.startPage <= 0) {
            this.startPage = 1;
        }

        if(this.lastPage <= 0) {
            this.lastPage = 10;
        }

        if(this.totalPage <= 0) {
            this.totalPage = 1;
        }

        if (this.lastBlock <= 0) {
            this.lastBlock = 1;
        }

        if(this.nextBlock <= 0) {
            this.nextBlock = 1;
        }

        if(this.totalBlock <= 0) {
            this.totalBlock = 1;
        }
        if(this.currentBlock <= 0) {
            this.currentBlock = 1;
        }
        this.limitPage = startPage - 1;
    }


    @Override
    public String toString() {
        return "Pager [totalPage=" + totalPage + ", totalBlock=" + totalBlock + ", listCount=" + listCount
                + ", blockCount=" + blockCount + ", currentBlock=" + currentBlock + ", currentSection=" + currentSection
                + ", startPage=" + startPage + ", lastPage=" + lastPage + ", startBlock=" + startBlock + ", lastBlock="
                + lastBlock + ", prevBlock=" + prevBlock + ", nextBlock=" + nextBlock + "]";
    }


}
