package dev.mvc.favorites;

/*
   frno                            NUMBER(10)       NOT NULL,
   memberno                       NUMBER(10)       NOT NULL
 */

public class FavoritesVO {
 
  private int frno;
  
  private int memberno;

  public int getFrno() {
	return frno;
  }

  public void setFrno(int frno) {
	this.frno = frno;
  }

  public int getMemberno() {
	return memberno;
  }

  public void setMemberno(int memberno) {
	this.memberno = memberno;
  }
  

  
}
