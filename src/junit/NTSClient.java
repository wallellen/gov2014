package junit;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class NTSClient extends Thread {
	Socket sk = null;  
    BufferedReader reader = null;  
    PrintWriter wtr = null;  
    BufferedReader keyin = null;  
  
    public NTSClient() throws Exception  
    {  
    	String str = "C:\\Users\\雪平\\Desktop\\RFC2045.txt";
    	byte[] b = new byte[4096];
    	InputStream in = new FileInputStream(str);
        keyin = new BufferedReader(new InputStreamReader(in));  
        try  
        {  
            sk = new Socket("voicet.oicp.net", 6637);  
        }  
        catch (Exception e)  
        {  
            e.printStackTrace();  
        }  
  
    }  
  
    public void run()  
    {  
        try  
        {  
            reader = new BufferedReader(new InputStreamReader(sk  
                    .getInputStream()));  
            wtr = new PrintWriter(sk.getOutputStream());  
            String get = keyin.readLine();  
  
            while (true)  
            {  
                if (get != null & get.length() > 0)  
                {  
                    wtr.println(get);  
                    wtr.flush();  
                  wtr.close();  
                  System.out.println(get + "发送完毕");  
                }  
                if (reader != null)  
                {  
                    //String line = reader.readLine();  
                    //System.out.println("从服务器来的信息：" + line);  
                      
                }  
                  
            }  
        }  
        catch (Exception e)  
        {  
            e.printStackTrace();  
        }  
    }  
  
   // public static void main(String [] args) throws Exception{  
        //new NTSClient().start();  
   // }  
    static Socket server;  
    
    public static void main(String[] args) throws Exception {  
        server = new Socket("voicet.oicp.net", 6637);  
        BufferedReader in = new BufferedReader(new InputStreamReader(  
                server.getInputStream()));  
        PrintWriter out = new PrintWriter(server.getOutputStream());  
        BufferedReader wt = new BufferedReader(new InputStreamReader(System.in));  
        while (true) {  
            String str = wt.readLine();  
            out.println(str);  
            out.flush();  
            if (str.equals("end")) {  
                break;  
            }  
            System.out.println(in.readLine());  
        }  
        server.close();  
    }  
}
