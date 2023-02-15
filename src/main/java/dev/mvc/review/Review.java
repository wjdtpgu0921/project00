package dev.mvc.review;

import java.io.File;

public class Review {
  /** 페이지당 출력할 레코드 갯수 */
  public static int RECORD_PER_PAGE = 15;

  /** 블럭당 페이지 수, 하나의 블럭은 1개 이상의 페이지로 구성됨, 많은 페이지 이동시 필요 */
  public static int PAGE_PER_BLOCK = 10;

  /** 목록 파일명 */
  public static String LIST_FILE = "list_by_cateno_search_paging.do";
  // public static String LIST_FILE = "list_by_cateno_grid.do";
  
}
