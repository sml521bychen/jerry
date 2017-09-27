package util;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.websocket.MessageInbound;
import org.apache.catalina.websocket.WebSocketServlet;
import org.apache.catalina.websocket.WsOutbound;

@SuppressWarnings("deprecation")
public class WebSocketAction extends WebSocketServlet {

	public static List<MyMessageInbound> mmiList = new ArrayList<MyMessageInbound>();

	@Override
	protected MyMessageInbound createWebSocketInbound(String str,
			HttpServletRequest request) {
		return new MyMessageInbound();
	}

	public class MyMessageInbound extends MessageInbound {
		WsOutbound myoutbound;

		// 开启websocket
		public void onOpen(WsOutbound outbound) {
			try {
				this.myoutbound = outbound;
				int num = (Integer) getServletContext().getAttribute("num");
				mmiList.add(this);
				outbound.writeTextMessage(CharBuffer.wrap(String.valueOf(num)));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}

		// 关闭websocket
		public void onClose(int status) {
			System.out.println("Close Client.");
			mmiList.remove(this);
		}

		// 当服务器端收到信息的时候,就对所有的连接进行遍历并且把收到的信息发送给所有用户
		public void onTextMessage(CharBuffer cb) throws IOException {
			System.out.println("Accept Message : " + cb);
			for (MyMessageInbound mmib : mmiList) {
				CharBuffer buffer = CharBuffer.wrap("你好啊");
				mmib.myoutbound.writeTextMessage(buffer);
				mmib.myoutbound.flush();
			}
		}

		public void onBinaryMessage(ByteBuffer bb) throws IOException {

		}
	}
}
