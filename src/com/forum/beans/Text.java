package com.forum.beans;

public class Text {
	private int tId;
	private String tname;
	private String context;
	private String img;
	private String bname;//板块名字
	private int bId;     //板块id
	private String date;
	private int userid;
	private int clicks;
	private String lastdate;
	
	

	public String getLastdate() {
		return lastdate;
	}
	public void setLastdate(String lastdate) {
		this.lastdate = lastdate;
	}
	public int getClicks() {
		return clicks;
	}
	public void setClicks(int clicks) {
		this.clicks = clicks;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public int gettId() {
		return tId;
	}
	public void settId(int tId) {
		this.tId = tId;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public int getbId() {
		return bId;
	}
	public void setbId(int bId) {
		this.bId = bId;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + bId;
		result = prime * result + ((date == null) ? 0 : date.hashCode());
		result = prime * result + tId;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Text other = (Text) obj;
		if (bId != other.bId)
			return false;
		if (date == null) {
			if (other.date != null)
				return false;
		} else if (!date.equals(other.date))
			return false;
		if (tId != other.tId)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "Text [tId=" + tId + ", tname=" + tname + ", context=" + context + ", img=" + img + ", bname=" + bname
				+ ", bId=" + bId + ", date=" + date + ", userid=" + userid + ", clicks=" + clicks + "]";
	}

	
	
	
	
	
}
