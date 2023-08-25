package com.example.self_board_project.core.tld;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

@SuppressWarnings("serial")
public class Paging extends TagSupport {

    private int totalPage;
    private int page;
    private int pageCount = 0;
    private String type;

    public int doStartTag() {

        JspWriter out = pageContext.getOut();

        int x = (this.pageCount == 0) ? 5 : this.pageCount;
        int p = this.page;
        int s = 0;
        int e = 0;
        int d = p % x; // 현재 페이지 위치

        switch (d) { // 루프의 처음 s 과 마지막 e
        case 1: // 현재 페이지가 네비게이션의 처음에 있을때..
            s = p;
            e = p + (x - 1);
            break;

        case 0: // 현재 페이지가 마지막에 있을때.
            s = p - (x - 1);
            e = p;
            break;

        default: // 중간에 꼈을때...
            s = p - (d - 1);
            e = p + (x - d);
        }

        StringBuffer dataList = new StringBuffer();

        if (e > totalPage)
            e = totalPage; // 루프의 마지막이 총페이지를 넘는지 체크

        if(p != 1 && s-1 > 0){
            dataList.append("<a href='javascript:goPage(" + (s - 1) + "," + type + ")' class='btnFirst disabled'>처음 페이지</a> ");
            dataList.append("<a href='javascript:goPage(" + (p - 1) + "," + type + ")' class='btnPrev' disabled>이전 페이지</a>");
        } else if(p != 1){
            dataList.append("<a href='javascript:goPage(" + (p - 1) + "," + type + ")' class='btnPrev' disabled>이전 페이지</a>");
        }
        
        dataList.append("<div class='page'>");
        
        for (int i = s; i <= e; i++) {
            if (i == p) {
                dataList.append("<strong>" + i + "</strong> ");
            } else {
                dataList.append("<a href='javascript:goPage(" + i + "," + type + ")' >" + i + "</a> ");
            }
        }
        
        if(totalPage == 0) {
            dataList.append("<strong>1</strong> ");
        }
        
        dataList.append("</div>");

        if (p < totalPage && totalPage - e > 0) {
            dataList.append("<a href='javascript:goPage(" + (p + 1) + "," + type + ")' class='btnNext' disabled>다음 페이지</a>");
            dataList.append("<a href='javascript:goPage(" + (e + 1) + "," + type + ")'class='btnLast'>마지막 페이지</a>");
        } else if(p < totalPage) {
            dataList.append("<a href='javascript:goPage(" + (p + 1) + "," + type + ")' class='btnNext' disabled>다음 페이지</a>");
        }

        try {
            out.println(dataList);
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
        return SKIP_BODY;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

	public void setType(String type) {
		this.type = type;
	}

}
