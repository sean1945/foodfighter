package search;

public class SearchRestaurant {
	private int idx;
	private String name, region1, region2, address, ftype, price, score, image;
	
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setRegion1(String region1) {
		this.region1 = region1;
	}
	public void setRegion2(String region2) {
		this.region2 = region2;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setFtype(String ftype) {
		this.ftype = ftype;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
	public int getIdx() {
		return this.idx;
	}
	public String getName() {
		return this.name;
	}
	public String getRegion1() {
		return this.region1;
	}
	public String getRegion2() {
		return this.region2;
	}
	public String getAddress() {
		return this.address;
	}
	public String getFtype() {
		return this.ftype;
	}
	public String getPrice() {
		return this.price;
	}
	public String getScore() {
		return this.score;
	}
	public String getImage() {
		return this.image;
	}
}
