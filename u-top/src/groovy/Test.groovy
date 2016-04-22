/**
 * 
 */


import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.apache.commons.lang3.RandomUtils

import com.surelution.whistle.push.Menu;
import com.surelution.whistle.push.Pusher;

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
class Test {

	public static void main(String[] args) {
        String cmd = "";
        InputStreamReader isr = new InputStreamReader(new FileInputStream("/Users/johnny/Documents/workspace-ggts-3.3.0.RELEASE-suzhou/u-top/src/groovy/menu.txt"), "utf8");
        BufferedReader br = new BufferedReader(isr);
        String line = br.readLine();
        while(line != null) {
            cmd += line;
            cmd += "\n";
            line = br.readLine();
        }
//		println cmd
        br.close();
        Pusher p = new Pusher();
        p.setApiUrl("https://api.weixin.qq.com/cgi-bin/menu/create?"); 
        System.out.println(p.push(cmd));
    }
}
