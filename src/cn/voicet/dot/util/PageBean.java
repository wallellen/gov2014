package cn.voicet.dot.util;

public class PageBean {

	private int pageNo;			// 存放当前页
	private boolean firstPage;	// 判断当前页是否是第一页, 如果是返回true,否则返回false
	private boolean lastPage;	// 判断当前页是否是最后一页, 如果是返回true,否则返回false
	private int sumPage;		// 存放总页数
	private int pageSize;		// 当前页显示几条记录
	private int totalResult;	// 总记录数

	public void setSumPage(int sumPage) {
		this.sumPage = sumPage;
	}
	public int getSumPage() {
		return sumPage;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setFirstPage(boolean firstPage) {
		this.firstPage = firstPage;
	}
	public boolean getFirstPage() {
		return firstPage;
	}
	public void setLastPage(boolean lastPage) {
		this.lastPage = lastPage;
	}
	public boolean getLastPage() {
		return lastPage;
	}

	/**
	 * 获得每页的记录数
	 */
	public int getPageSize() {
		return pageSize;
	}
	/**
	 * 设置每页的记录数
	 * @param pageSize 记录数
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalResult() {
		return totalResult;
	}
	public void setTotalResult(int totalResult) {
		this.totalResult = totalResult;
	}

}
