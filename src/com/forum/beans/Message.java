package com.forum.beans;

public class Message {
	private int mid;
	private String senderid;
	private String reciverid;
	private String message;
	private String date;
	private String statu;
	private int tid;
	
	
	
	
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public String getSenderid() {
		return senderid;
	}
	public void setSenderid(String senderid) {
		this.senderid = senderid;
	}
	public String getReciverid() {
		return reciverid;
	}
	public void setReciverid(String reciverid) {
		this.reciverid = reciverid;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getStatu() {
		return statu;
	}
	public void setStatu(String statu) {
		this.statu = statu;
	}
	@Override
	public String toString() {
		return "Message [sender=" + senderid + ", reciver=" + reciverid + ", message=" + message + ", date=" + date
				+ ", statu=" + statu + "]";
	}
	
}
