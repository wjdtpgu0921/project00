<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dev.mvc.fcate.FCateVO" %>

<DIV class='container_main'> 
  <%-- 화면 상단 메뉴 --%>
  <DIV class='top_img'>
    <DIV class='top_menu_label'>Resort 2.0 영화와 여행이있는 리조트</DIV>
    <NAV class='top_menu'>
      <A class='menu_link'  href='/' >힐링 리조트</A><span class='top_menu_sep'> </span>
      
      <%
              ArrayList<FCateVO> list = (ArrayList<FCateVO>)request.getAttribute("list");
              for (int index=0; index < list.size(); index++) {
                FCateVO cateVO = list.get(index);
            %>
        <A href="/contents/list_by_cateno_search_paging.do?cateno=<%=cateVO.getCateno() %>" class="menu_link"><%=cateVO.getName() %></A><span class='top_menu_sep'> </span>
      <%
      }      
      %>

      <%-- 사용자 메뉴 --%>
      <A class='menu_link'  href='/contents/list_all.do'>전체 글</A><span class='top_menu_sep'> </span>
            
      <%-- 관리자 메뉴 --%>
      <A class='menu_link'  href='/cate/list_all.do'>카테고리</A><span class='top_menu_sep'> </span>
            
    </NAV>
  </DIV>
  
  <%-- 내용 --%> 
  <DIV class='content'>
   