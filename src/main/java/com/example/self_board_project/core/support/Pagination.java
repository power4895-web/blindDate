package com.example.self_board_project.core.support;

public class Pagination {
    
	private Integer page;			//현제 페이지
	private Integer rowSize;		//로우 수
	private int totalRow;			//전체 목록수
	
	//검색 추가
	private String searchKey;		//검색에서 셀렉트 박스 안에 있는 키(이름,제목)
	private String searchValue;		//검색어
	
	public Integer getPage() {
		return page == null ? 1 : page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public int getTotalRow() {
		return totalRow;
	}
	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
	}
	//페이지당 보여줘야 할 개수
	public Integer getRowSize() {
		return rowSize == null ? 15 : rowSize;
	}
	public void setRowSize(Integer rowSize) {
		this.rowSize = rowSize;
	}
	/**
	 * 총페이지 수
	 * @return
	 */
	public int getTotalPage() {
		return (int)Math.ceil( (double)getTotalRow() / (double)getRowSize());
	}

	/**
	 * 시작 로우
	 * @return
	 */ 
	public int getRowStart() {
		return (getPage() -1) * getRowSize();
	}
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	@Override
	public String toString() {
		return "Pagination [page=" + page + ", rowSize=" + rowSize + ", totalRow=" + totalRow + ", searchKey="
				+ searchKey + ", searchValue=" + searchValue + "]";
	}
    
}
