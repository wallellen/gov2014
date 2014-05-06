package cn.voicet.dot.datasource;

/**
 * 获取和设置上下文环境�?
 */
@SuppressWarnings("unchecked")
public class DataSourceContextHolder {
	
	private static final ThreadLocal contextHolder = new ThreadLocal(); // 线程本地环境

	// 设置数据源类�?
	public static void setDataSourceType(String dataSourceType) {
		contextHolder.set(dataSourceType);
	}

	// 获取数据源类�?�??
	public static String getDataSourceType() {
		return (String) contextHolder.get();
	}

	// 清除数据源类�?
	public static void clearDataSourceType() {
		contextHolder.remove();
	}
}
