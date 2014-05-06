package cn.voicet.dot.util;


/**
 * @author Administrator
 *
 */
import javax.servlet.http.HttpServletRequest;

@SuppressWarnings("unused")
public class PageInfo {
	//HTTP请求
	private HttpServletRequest request;
    //每页的记录数
    private int pageSize;
    //当前页
    private int currentPageNo = 1;
    //开始记录数
    private int beginResult = 0;
    //总记录数
    private int totalResult = 0;
    //总页数
    private int totalPage = 0;
    
    private PageBean page=null;

    /**
     * 初始化
     * @param req HttpServletRequest HTTP请求
     */
    public PageInfo(HttpServletRequest request) {
       this.currentPageNo = request.getParameter("pageNO")!=null && !request.getParameter("pageNO").equals("")?new Integer(request.getParameter("pageNO")).intValue():1;
       this.pageSize = request.getParameter("pagesize")!=null && !request.getParameter("pagesize").equals("")?new Integer(request.getParameter("pagesize")).intValue():10;
       if(this.pageSize<=0){
    	   this.pageSize=10;
       }
       this.request = request;      
    }
    
    public PageInfo(){
    	this.currentPageNo=1;
    	this.pageSize=10;
    }
    
    public PageInfo(int currentPageNo){
    	this.currentPageNo=currentPageNo;
    	this.pageSize=10;
    }
    
    /**
     * @see 计算总页数
     */
    private void countPages() {
        if(totalResult==0) {
            this.totalPage=1;
        }
        else {
            this.totalPage = (totalResult / pageSize); //总共几页
            if ((totalResult % pageSize) != 0) this.totalPage = this.totalPage + 1;
        }
    }

    public boolean isFirstPage() {
    	if (this.currentPageNo<=1) {
    		return true;
    	} else {
    		return false;	
    	}	
    }
    
    public boolean isLastPage(){
    	if(this.currentPageNo>=this.totalPage){
    		return true;
    	}else{
    		return false;	
    	}	
    }
    
    /**
     * 获得当前页
     * @return 当前页
     */
    public int getCurrentPageNo() {
         return currentPageNo;
    }

    /**
     * 获得每页的记录数
     * @return int
     */
    public int getPageSize() {
    	System.out.println("每页记录数："+pageSize);
        return pageSize;
    }

    /**
     * 获得总记录数
     * @return int
     */
    public int getTotalResult() {
        return totalResult;
    }

    /**
     * 设置当前页
     * @param current int 当前页码
     */
    public void setCurrentPageNo(int current) {
        this.currentPageNo  =current;
    }

    /**
     * 设置每页的记录数
     * @param i int 记录数
     */
    public void setPageSize(int i) {
        this.pageSize = i;
    }

    /**
     * 获得开始记录数
     * @return int开始记录数
     */
    public int getBeginResult() {
    	// 总页数不等于1
        if(totalPage!=1) {	
        	// 当前页大于等于总页数
        	if(currentPageNo>=totalPage){	
        		// 设置当前页等于总页数
        		currentPageNo=totalPage;	
        		//设置beginResult的值, 表示当前页从第几条开始检索
        		beginResult= (currentPageNo - 1) * pageSize;
        		// 设置pageSize属性, 表示当前页显示几条数据
                pageSize=totalResult-beginResult;
            }else{
            	// 使用beginResult属性存放当前页从第几条数据开始检索
            	beginResult = (currentPageNo - 1) * pageSize;
        	}
        }
        // 总页数等于1
        if(totalPage==1) {
        	// 设置当前页等于总页数
        	currentPageNo=totalPage;
        	// 设置beginResult=0, 表示当前页从第1条开始检索
        	beginResult=0;
        	// 设置当前页显示的记录数等于总的记录数
        	pageSize=totalResult;
        }
        setRequestValue();   
        System.out.println("开始记录数："+beginResult);
        return beginResult;
    }

    public void setBeginResult(int i) {
        this.beginResult = i;
    }

    /**
     * 获得总页数
     * @return 总页数
     */
    public int getTotalPage() {
        return totalPage;
    }

    /**
     * @param totalResult
     *  The totalResult to set. 设置该分页信息总共有多少条记录
     */
    public void setTotalResult(int totalResult) {
        this.totalResult = totalResult;
        countPages();
    }

    /**
     * 设置序号
     */
    private void setRequestValue(){    	
    	page=new PageBean();
    	page.setFirstPage(isFirstPage());
    	page.setLastPage(isLastPage()); 		
        page.setPageNo(currentPageNo);	
    	page.setPageSize(pageSize);
    	page.setSumPage(totalPage);
    	page.setTotalResult(totalResult);
    }
    
    public PageBean getPageBean(){
    	return page;
    }
    
    public void setTotalPage(int totalPage){
    	this.totalPage=totalPage;
    }
  
}
