package foodfighter.searchlocal;

public class SearchpageDto {
	private int page,pstart,pend,chong;
	private String region1,region2;
	
	public String getRegion1() {
		return region1;
	}

	public void setRegion1(String region1) {
		this.region1 = region1;
	}

	public String getRegion2() {
		return region2;
	}

	public void setRegion2(String region2) {
		this.region2 = region2;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPstart() {
		return pstart;
	}

	public void setPstart(int pstart) {
		this.pstart = pstart;
	}

	public int getPend() {
		return pend;
	}

	public void setPend(int pend) {
		this.pend = pend;
	}

	public int getChong() {
		return chong;
	}

	public void setChong(int chong) {
		this.chong = chong;
	}
}
