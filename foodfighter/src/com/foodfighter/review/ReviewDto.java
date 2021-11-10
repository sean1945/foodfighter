package com.foodfighter.review;

import java.util.ArrayList;

import com.foodfighter.content.ImageDto;

public class ReviewDto {
	int idx, rest_idx, user_idx, cnt;
	String content, regdate, name, restaurant, userid;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getRestaurant() {
		return restaurant;
	}
	public void setRestaurant(String restaurant) {
		this.restaurant = restaurant;
	}
	ArrayList<ImageDto> imagelist;
	
	public ArrayList<ImageDto> getImagelist() {
		return imagelist;
	}
	public void setImagelist(ArrayList<ImageDto> imagelist) {
		this.imagelist = imagelist;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	float score;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getRest_idx() {
		return rest_idx;
	}
	public void setRest_idx(int rest_idx) {
		this.rest_idx = rest_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public float getScore() {
		return score;
	}
	public void setScore(float score) {
		this.score = score;
	}
	
}
