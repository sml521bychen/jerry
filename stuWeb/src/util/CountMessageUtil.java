package util;

import java.io.IOException;
import java.nio.CharBuffer;

import util.WebSocketAction.MyMessageInbound;

public class CountMessageUtil {
	public static void sendCountMessage(int num) {

		for (MyMessageInbound mmib : WebSocketAction.mmiList) {
			try {
				CharBuffer buffer = CharBuffer.wrap(String.valueOf(num));
				mmib.myoutbound.writeTextMessage(buffer);
				mmib.myoutbound.flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
