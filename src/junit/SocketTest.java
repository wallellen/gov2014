package junit;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.EOFException;
import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;

public class SocketTest {
	public static void main(String[] args) throws Exception{
		Socket soc = null;  
        String data = "";  
        InetAddress addr = InetAddress.getByName("58.210.73.86");  
        int serverPort = 80;  
        for (int i=0; i<10; i++){
	        if (addr.isReachable(5000)) {  
	            System.out.println(i + "SUCCESS - ping " + addr  
	                    + " with no interface specified");  
	            try {  
	                soc = new Socket(addr, serverPort);  
	                System.out.println("Socket Success!");  
	                DataInputStream in = new DataInputStream(soc.getInputStream());  
	                DataOutputStream out=new DataOutputStream(soc.getOutputStream());  
	                String str = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><cmd>ReadWeight</cmd>";  
	                byte[] b = str.getBytes();  
	                out.write(b);  
	                byte[] b2 = new byte[4096];  
	                int count = in.read(b2, 0, b2.length);  
	                data = new String(b2,0,count,"UTF-8");  
	                //this.DOM(data);  
	            } catch (UnknownHostException e) {  
	                System.out.println("Socket Error:" + e.getMessage());  
	            } catch (EOFException e) {  
	                System.out.println("EOF:" + e.getMessage());  
	            } catch (IOException e) {  
	                System.out.println("IO:" + e.getMessage());  
	            } finally {  
	                if (soc != null)  
	                    try {  
	                        soc.close();  
	                    } catch (IOException e) {/* close failed */  
	                    }  
	            }  
	        } else {  
	            System.out.println("FAILURE - ping " + addr  
	                    + " with no interface specified");  
	        }  
        }
	}
}
