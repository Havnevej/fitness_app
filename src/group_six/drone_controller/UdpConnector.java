package group_six.drone_controller;

import java.io.IOException;
import java.net.*;

public class UdpConnector implements Runnable{
    private DatagramSocket socket;
    private final int udp_listen_port = 7000;
    private final int udp_send_port = 7009;
    private Controller message_handler;
    private boolean receiveMessages = true;

    public UdpConnector(Controller message_handler)
    {
        this.message_handler = message_handler;
        setupSocket();
    }

    public void close_socket()
    {
        this.socket.close();
    }

    private void setupSocket() {
        try {

            socket = new DatagramSocket(udp_listen_port);
        } catch (SocketException e) {
            System.out.println("IOEXCEPTION: Tried to create new datagramsocket on "+ udp_listen_port);
            System.out.println(e.getMessage());
        }
    }

    private void sendMessage(String string, InetAddress address)
    {
        sendMessage(string.getBytes(), address);
    }

    private void sendMessage(byte[] bytes, InetAddress address)
    {
        DatagramPacket packet = new DatagramPacket(bytes, bytes.length, address, udp_send_port);
        try {
            socket.send(packet);
        } catch (IOException e) {
            System.out.println("IOEXCEPTION: Tried to send packet");
        }
    }

    private UdpMessage receive_message() {
        byte[] buf = new byte[256];
        DatagramPacket packet = new DatagramPacket(buf, buf.length);
        try {
            socket.receive(packet);
            UdpMessage message = new UdpMessage(packet.getData(), packet.getLength(), packet.getAddress() , packet.getPort());

            Main.move_drone(UdpMessage.message);
            if(UdpMessage.length <=2){ // will be potentiometer always
                Main.set_speed_of_drone(UdpMessage.message);
            }

            if (receiveMessages) message_handler.receiveMessage(message);
            sendMessage("ok", InetAddress.getByName(message.getIp())); //sends back OK to the ESP, this will make the LED blink to indicate activity
            return message;
        } catch (IOException e) {
            System.out.println("IOEXCEPTION: Tried to receive packet");
            return null;
        }
    }

    public void udp_monitor()
    {
        UdpMessage message = receive_message();
        try {
            if (receiveMessages) sendMessage("ok", InetAddress.getByName(message.getIp()));
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void run() {
        connection_main_loop();
    }

    public void connection_main_loop() {
        System.out.println("Started UDP Monitor");
        do {
            udp_monitor();
        } while(is_receiving_messages());
    }

    private boolean is_receiving_messages() {
        return receiveMessages;
    }
}
