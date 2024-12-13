package bookshop.example;

public class Book {
	private int no;
	private String title;
	private String author;
	private int stateCode;
	
	public Book(int no, String title, String author) {
		this.no = no;
		this.title = title;
		this.author = author;
		this.stateCode = 1;
	}
	
	public int getNo() {
		return no;
	}

	public void rent() {
		this.stateCode = 0;
		System.out.println(this.title + "이(가) 대여 됐습니다.");
	}
	
	public void print() {
		System.out.print("책 제목:"+this.title+", 작가:"+this.author+", 대여 유무:");
		if(this.stateCode ==1) {
			System.out.println("재고있음");
		}
		else {
			System.out.println("대여중");
		}
	}
}
