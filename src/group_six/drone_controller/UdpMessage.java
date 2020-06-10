package group_six.drone_controller;

import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Date;

public class UdpMessage {
    private String time;
    private String message;
    private String ip;
    private int length;
    private int port;

    public UdpMessage(String message, String ip, int port)
    {
        SimpleDateFormat formatter;
        formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date time = new Date();
        this.time =formatter.format(time);
        this.message = message;
        this.ip = ip;
        this.length = message.length();
        this.port = port;
    }

    public UdpMessage(byte[] message, int msgLength, InetAddress ip, int port)
    {
        //call other constructor
        this(new String(message, 0, msgLength), ip.getHostAddress(), port );
    }
     public String getTime() { return time; }                    //used for reflection data retrieval
     public String getMessage() { return message; }              //used for reflection data retrieval
     int getLength() { return length; }
     public String getIp() { return ip; }                        //used for reflection data retrieval
     public String getIpAndString() { return ip + ":" + port; }  //used for reflection data retrieval

    @Override
    public String toString() {
        return "UdpMessage{" +
                "time='" + time + '\'' +
                ", message='" + message + '\'' +
                ", ip='" + ip + '\'' +
                ", length=" + length +
                ", port=" + port +
                '}';
    }
}

