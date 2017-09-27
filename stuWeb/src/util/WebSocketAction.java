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

		// ����websocket
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

		// �ر�websocket
		public void onClose(int status) {
			System.out.println("Close Client.");
			mmiList.remove(this);
		}

		// �����������յ���Ϣ��ʱ��,�Ͷ����е����ӽ��б������Ұ��յ�����Ϣ���͸������û�
		public void onTextMessage(CharBuffer cb) throws IOException {
			System.out.println("Accept Message : " + cb);
			for (MyMessageInbound mmib : mmiList) {
				CharBuffer buffer = CharBuffer.wrap("��ð�");
				mmib.myoutbound.writeTextMessage(buffer);
				mmib.myoutbound.flush();
			}
		}

		public void onBinaryMessage(ByteBuffer bb) throws IOException {

		}
	}
}
